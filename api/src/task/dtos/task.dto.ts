import { ObjectType, Field } from '@nestjs/graphql';

import { ProjectDto } from 'src/project/dtos/project.dto';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { UserDto } from 'src/user/user.dto';

@ObjectType()
export class TaskDto {
  @Field()
  id!: string;

  @Field()
  name!: string;

  @Field({ nullable: true })
  description?: string;

  @Field(() => UserDto, { nullable: true })
  assignedTo?: UserDto;

  @Field(() => TaskStatusType, { nullable: true })
  taskStatusType!: TaskStatusType;

  @Field(() => ProjectDto)
  project!: ProjectDto;
}
