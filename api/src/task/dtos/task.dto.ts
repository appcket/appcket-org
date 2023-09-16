import { ObjectType, Field } from '@nestjs/graphql';

import { BaseDto } from 'src/common/dtos/base.dto';
import { ProjectDto } from 'src/project/dtos/project.dto';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { UserDto } from 'src/user/user.dto';

@ObjectType()
export class TaskDto extends BaseDto {
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
