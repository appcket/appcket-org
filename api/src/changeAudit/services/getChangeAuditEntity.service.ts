import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityManager, EntityRepository } from '@mikro-orm/postgresql';
import { FindOptions } from '@mikro-orm/core';
import { Logger } from '@nestjs/common';

import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

@Injectable()
export class GetChangeAuditEntityService {
  private readonly logger = new Logger(GetChangeAuditEntityService.name);

  constructor(
    @InjectRepository(ChangeAuditEntity)
    private readonly changeAuditEntityRepository: EntityRepository<ChangeAuditEntity>,
    private readonly em: EntityManager,
  ) {}

  public async getChangeAuditEntity(
    appId: string,
    entityId: string,
    entityType: string,
    operationType: ChangeAuditOperationTypes = ChangeAuditOperationTypes.Update,
    findOptions: FindOptions<ChangeAuditEntity>,
  ): Promise<ChangeAuditEntity> {
    return await this.changeAuditEntityRepository.findOne(
      {
        entityId,
        entityType,
        appId,
        operationType,
      },
      findOptions,
    );
  }

  public async getChangeAuditEntities(
    appId: string,
    entityIds: string[],
  ): Promise<ChangeAuditEntity[]> {
    // get latest updated version of specified each entity
    const knex = this.em.getKnex();
    const qb1 = this.em
      .createQueryBuilder(ChangeAuditEntity, 'cae2')
      .select(['max(cae2.created_at)'])
      .where({ entityId: knex.ref('cae1.entity_id') })
      .andWhere({ appId })
      .andWhere({ operationType: ChangeAuditOperationTypes.Update })
      .andWhere({ entityId: { $in: entityIds } });
    const qb2 = this.em
      .createQueryBuilder(ChangeAuditEntity, 'cae1')
      .select(['id', 'entity_id', 'created_at', 'operation_type_id', 'user_id'])
      .where({ createdAt: { $eq: qb1.getKnexQuery() } });

    const updateResults = await qb2.execute('all');
    const updateEntities = updateResults.map((entity) => this.em.map(ChangeAuditEntity, entity));

    const createEntities = await this.changeAuditEntityRepository.find(
      {
        appId,
        entityId: { $in: entityIds },
        operationType: ChangeAuditOperationTypes.Create,
      },
      { fields: ['id', 'entityId', 'createdAt', 'operationType.id', 'userId'] },
    );

    const result = createEntities.concat(updateEntities);

    return result;
  }

  public async getAllChangeAuditEntityVersions(
    appId: string,
    entityId: string,
    findOptions: FindOptions<ChangeAuditEntity>,
  ): Promise<ChangeAuditEntity[]> {
    return await this.changeAuditEntityRepository.find(
      {
        appId,
        entityId,
      },
      findOptions,
    );
  }
}
