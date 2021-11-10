-- CreateTable
CREATE TABLE "organization" (
    "organization_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(30) NOT NULL,
    "created_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(0),
    "updated_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" UUID,
    "updated_by" UUID,
    "deleted_by" UUID,

    PRIMARY KEY ("organization_id")
);

-- CreateTable
CREATE TABLE "organization_user" (
    "organization_user_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "organization_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(0),
    "created_by" UUID,
    "updated_by" UUID,
    "deleted_by" UUID,

    PRIMARY KEY ("organization_user_id")
);

-- CreateTable
CREATE TABLE "task" (
    "task_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "assigned_to" UUID,
    "created_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(0),
    "created_by" UUID,
    "updated_by" UUID,
    "deleted_by" UUID,
    "task_status_type_id" UUID,

    PRIMARY KEY ("task_id")
);

-- CreateTable
CREATE TABLE "task_status_type" (
    "task_status_type_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(30),
    "created_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(0),
    "created_by" UUID,
    "updated_by" UUID,
    "deleted_by" UUID,

    PRIMARY KEY ("task_status_type_id")
);

-- CreateTable
CREATE TABLE "team" (
    "team_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(50) NOT NULL,
    "organization_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(0),
    "created_by" UUID,
    "updated_by" UUID,
    "deleted_by" UUID,

    PRIMARY KEY ("team_id")
);

-- CreateTable
CREATE TABLE "team_user" (
    "team_user_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "team_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(0),
    "created_by" UUID,
    "updated_by" UUID,
    "deleted_by" UUID,

    PRIMARY KEY ("team_user_id")
);

-- CreateIndex
CREATE INDEX "organization_user_id_idx" ON "organization_user"("organization_user_id");

-- AddForeignKey
ALTER TABLE "organization_user" ADD FOREIGN KEY ("organization_id") REFERENCES "organization"("organization_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "task" ADD FOREIGN KEY ("task_status_type_id") REFERENCES "task_status_type"("task_status_type_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team" ADD FOREIGN KEY ("organization_id") REFERENCES "organization"("organization_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team_user" ADD FOREIGN KEY ("team_id") REFERENCES "team"("team_id") ON DELETE CASCADE ON UPDATE CASCADE;
