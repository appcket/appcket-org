import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { CommonService } from '@/common/services/common.service';
import { TaskStatusType } from '@/taskStatusType/taskStatusType.entity';

@Injectable()
export class GetTaskStatusTypesService {
  constructor(
    @InjectRepository(TaskStatusType)
    private readonly taskStatusTypeRepository: EntityRepository<TaskStatusType>,
    private commonService: CommonService,
  ) {}

  public async getAll(): Promise<TaskStatusType[]> {
    const taskStatusTypes = await this.taskStatusTypeRepository.findAll();

    return taskStatusTypes;
  }
}
