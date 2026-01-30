export interface EventEnvelope<T = any> {
  /**
   * Broad category of the event (e.g., 'entity_change', 'system_notification')
   */
  type: string;

  /**
   * The name of the resource/entity involved (e.g., 'Team', 'Project')
   */
  resource: string;

  /**
   * The action performed (e.g., 'insert', 'update', 'delete')
   */
  action: string;

  /**
   * The unique ID of the resource
   */
  id?: string;

  /**
   * The actual data payload associated with the event (from the outbox table)
   */
  payload?: T;

  /**
   * Timestamp when the event occurred (ISO string)
   */
  timestamp?: string;
}
