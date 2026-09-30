import { ObjectType, Field } from '@nestjs/graphql';

import { BaseDto } from '@/common/dtos/base.dto';
import { ProjectDto } from '@/project/dtos/project.dto';
import { TaskStatusType } from '@/taskStatusType/taskStatusType.entity';
import { UserDto } from '@/user/user.dto';

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
