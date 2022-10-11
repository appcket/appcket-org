import { ObjectType, Field } from '@nestjs/graphql';
import { Entity, ManyToOne, OneToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { Project } from 'src/project/project.entity';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ schema: 'appcket' })
export class Task {
  @Field()
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Field()
  @Property({ length: 100 })
  name!: string;

  @Field()
  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @Field()
  @OneToOne({ entity: () => User, fieldName: 'assigned_to', onUpdateIntegrity: 'cascade' })
  assignedTo!: User;

  @Field()
  @ManyToOne({
    entity: () => TaskStatusType,
    fieldName: 'task_status_type_id',
    onUpdateIntegrity: 'cascade',
    onDelete: 'set null',
    nullable: true,
  })
  taskStatusType?: TaskStatusType;

  @Field()
  @ManyToOne({ entity: () => Project, fieldName: 'project_id', onUpdateIntegrity: 'cascade' })
  project!: Project;
}
