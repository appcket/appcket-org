#!/bin/bash
set -euo pipefail

CH_HOST="localhost:8123"
CH_USER="dbuser"
CH_PASS="Ch@ng3To@StrongP@ssw0rd"

# Helper function to run query
run_query() {
    echo "Running: $1"
    curl -s -u "${CH_USER}:${CH_PASS}" "${CH_HOST}" -d "$1"
    echo -e "\n----------------------------------------"
}

# 1. Create the Database if not exists
run_query "CREATE DATABASE IF NOT EXISTS appcket"

# 2. Cleanup old tables (for dev environment schema evolution)
run_query "DROP TABLE IF EXISTS appcket.outbox_events_mv"
run_query "DROP TABLE IF EXISTS appcket.outbox_events_history"
run_query "DROP TABLE IF EXISTS appcket.outbox_events_queue"

# 3. Create the Target History Table (MergeTree)
# Added entity_id and entity_type for fast filtering
run_query "CREATE TABLE IF NOT EXISTS appcket.outbox_events_history
(
    id String,
    action String,
    table_schema String,
    table_name String,
    entity_id String,
    entity_type String,
    user_id String,
    payload String,
    committed_at DateTime64(3),
    ingested_at DateTime DEFAULT now()
)
ENGINE = MergeTree
ORDER BY (entity_type, entity_id, committed_at)"

# 4. Create the Kafka Engine Table
# Note: We use host.docker.internal:31092 to reach Redpanda's NodePort from inside the Docker container.
# Ensure this port matches 'kubectl get svc -n redpanda redpanda-external'
KAFKA_PORT=$(kubectl get svc -n redpanda redpanda-external -o jsonpath='{.spec.ports[?(@.name=="kafka-default")].nodePort}')
echo "Detected Redpanda External Port: $KAFKA_PORT"

run_query "CREATE TABLE IF NOT EXISTS appcket.outbox_events_queue
(
    record String,
    action String,
    metadata String
)
ENGINE = Kafka
SETTINGS kafka_broker_list = 'host.docker.internal:${KAFKA_PORT}',
         kafka_topic_list = 'outbox-events',
         kafka_group_name = 'clickhouse_consumer',
         kafka_format = 'JSONEachRow',
         kafka_skip_broken_messages = 1"

# 5. Create the Materialized View to ingest data
# We now extract entity.id and entity.type from the JSON payload
run_query "CREATE MATERIALIZED VIEW IF NOT EXISTS appcket.outbox_events_mv TO appcket.outbox_events_history AS
SELECT
    JSONExtractString(record, 'id') as id,
    action,
    JSONExtractString(metadata, 'table_schema') as table_schema,
    JSONExtractString(metadata, 'table_name') as table_name,
    JSONExtractString(record, 'payload', 'entity', 'id') as entity_id,
    JSONExtractString(record, 'payload', 'entity', 'type') as entity_type,
    JSONExtractString(record, 'payload', 'user', 'id') as user_id,
    JSONExtractString(record, 'payload') as payload,
    parseDateTime64BestEffortOrNull(JSONExtractString(metadata, 'commit_timestamp')) as committed_at
FROM appcket.outbox_events_queue"

echo "✅ ClickHouse configured to consume Redpanda events with optimized schema."