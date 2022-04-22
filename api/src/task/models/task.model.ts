import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

import { Project } from 'src/project/models/project.model';
import { TaskStatusType } from 'src/taskStatusType/models/taskStatusType.model';
import { User } from 'src/user/models/user.model';

@ObjectType()
export class Task {
  @Field((type) => String)
  task_id: string;

  @Field()
  name: string;

  @Field()
  description: string;

  @Field((type) => String)
  assigned_to: string;

  @Field(() => User) assigned_to_user: User;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;

  @Field()
  project?: Project;

  @Field((type) => String)
  task_status_type_id: string;

  @Field()
  task_status_type: TaskStatusType;
}
