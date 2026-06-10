import { ObjectType, Field } from '@nestjs/graphql';
import { Entity, PrimaryKey, Property } from '@mikro-orm/decorators/legacy';

@ObjectType()
@Entity({ schema: 'appcket', tableName: 'task_status_type' })
export class TaskStatusType {
  @Field()
  @PrimaryKey({ length: 50, type: 'varchar' })
  id!: string;

  @Field()
  @Property({ length: 50, type: 'varchar' })
  name!: string;
}
