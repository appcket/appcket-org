import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@Entity({ schema: 'appcket' })
export class TaskStatusType {
  @PrimaryKey({ length: 50 })
  id!: string;

  @Property({ length: 50, nullable: true })
  name?: string;
}
