import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@mikro-orm/nestjs';
import { EntityManager } from '@mikro-orm/core';
import { when } from 'jest-when';

import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { ChangeAuditApp } from 'src/changeAudit/entities/changeAuditApp.entity';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

describe('CreateChangeAuditChangeService', () => {
  let service: CreateChangeAuditChangeService;

  const ENTITY_ID = '2393e739-c7d3-46a4-bd13-44d21bc8f4e6';
  const APP_ID = 'd1f3593d-aff4-409a-b297-961078a162c7';

  const changeInitial = {
    appId: APP_ID,
    operationType: ChangeAuditOperationTypes.Create,
    entity: {
      id: '1234',
      type: 'task',
      data: {
        title: 'Investigate Typescript Starter Kits for New Project',
        description:
          "We need an easy and quick way to kickstart the new Project Bosco initiative. I think (https://appcket.org)[https://appcket.org] could give us a shortcut so we don't have to build all the basic web app functionality ourselves.",
        status: 'To Do',
        assignedTo: '101',
        priority: 'Low',
        list: [{ id: 1, name: 'List item 1' }],
      },
    },
    user: {
      id: '101',
      email: 'test@test.xyz',
      displayName: 'Test Tester',
    },
    timestamp: new Date('2023-08-23 07:39:18.000'),
  };

  const changeUpdated = {
    appId: APP_ID,
    operationType: ChangeAuditOperationTypes.Update,
    entity: {
      id: '1234',
      type: 'task',
      data: {
        title: 'Implement New Project with Appcket Starter Kit',
        description:
          'I looked at many open source and commercial Typescript based boilerplates and investigated the Appcket docs. Was able to get everything running locally. Made a quick spike and the developer experience was great. I recommend moving forward and building the new app using Appcket as the base.',
        status: 'Doing',
        assignedTo: '202',
        priority: 'High',
        list: [
          { id: 1, name: 'List item 1' },
          { id: 2, name: 'List item 2' },
        ],
      },
    },
    user: {
      id: '202',
      email: 'test2@test.xyz',
      displayName: 'Test2 Tester',
    },
    timestamp: new Date('2023-08-23 07:39:18.000'),
  };

  const createdEntity: ChangeAuditEntity = {
    id: ENTITY_ID,
    entityId: changeInitial.entity.id,
    appId: new ChangeAuditApp(),
    operationType: {
      id: changeInitial.operationType,
      name: changeInitial.operationType,
    },
    userId: changeInitial.user.id,
    userEmail: changeInitial.user.email,
    userDisplayName: changeInitial.user.displayName,
    entityType: 'task',
    entity: JSON.stringify(changeInitial.entity),
    createdAt: new Date('2023-08-23 07:39:18.000'),
    diff: null,
  };

  const CHANGE_INITIAL_DATA = {
    entityId: changeInitial.entity.id,
    appId: changeInitial.appId,
    userId: changeInitial.user.id,
    userEmail: changeInitial.user.email,
    userDisplayName: changeInitial.user.displayName,
    entity: changeInitial.entity,
  };

  const updatedEntity: ChangeAuditEntity = {
    id: ENTITY_ID,
    entityId: changeUpdated.entity.id,
    appId: new ChangeAuditApp(),
    operationType: {
      id: changeUpdated.operationType,
      name: changeUpdated.operationType,
    },
    userId: changeUpdated.user.id,
    userEmail: changeUpdated.user.email,
    userDisplayName: changeUpdated.user.displayName,
    entityType: 'task',
    entity: JSON.stringify(changeUpdated.entity),
    createdAt: new Date('2023-08-23 07:39:18.000'),
  };

  const CHANGE_UPDATED_DATA = {
    entityId: changeUpdated.entity.id,
    appId: changeUpdated.appId,
    userId: changeUpdated.user.id,
    userEmail: changeUpdated.user.email,
    userDisplayName: changeUpdated.user.displayName,
    entity: changeUpdated.entity,
  };

  const CHANGES = [
    {
      changeAuditEntity: ENTITY_ID,
      entityId: changeUpdated.entity.id,
      entityType: changeUpdated.entity.type,
      userId: changeUpdated.user.id,
      userEmail: changeUpdated.user.email,
      userDisplayName: changeUpdated.user.displayName,
      fieldName: 'title',
      oldValue: changeInitial.entity.data.title,
      newValue: changeUpdated.entity.data.title,
    },
    {
      changeAuditEntity: ENTITY_ID,
      entityId: changeUpdated.entity.id,
      entityType: changeUpdated.entity.type,
      userId: changeUpdated.user.id,
      userEmail: changeUpdated.user.email,
      userDisplayName: changeUpdated.user.displayName,
      fieldName: 'description',
      oldValue: changeInitial.entity.data.description,
      newValue: changeUpdated.entity.data.description,
    },
    {
      changeAuditEntity: ENTITY_ID,
      entityId: changeUpdated.entity.id,
      entityType: changeUpdated.entity.type,
      userId: changeUpdated.user.id,
      userEmail: changeUpdated.user.email,
      userDisplayName: changeUpdated.user.displayName,
      fieldName: 'status',
      oldValue: changeInitial.entity.data.status,
      newValue: changeUpdated.entity.data.status,
    },
    {
      changeAuditEntity: ENTITY_ID,
      entityId: changeUpdated.entity.id,
      entityType: changeUpdated.entity.type,
      userId: changeUpdated.user.id,
      userEmail: changeUpdated.user.email,
      userDisplayName: changeUpdated.user.displayName,
      fieldName: 'assignedTo',
      oldValue: changeInitial.entity.data.assignedTo,
      newValue: changeUpdated.entity.data.assignedTo,
    },
    {
      changeAuditEntity: ENTITY_ID,
      entityId: changeUpdated.entity.id,
      entityType: changeUpdated.entity.type,
      userId: changeUpdated.user.id,
      userEmail: changeUpdated.user.email,
      userDisplayName: changeUpdated.user.displayName,
      fieldName: 'priority',
      oldValue: changeInitial.entity.data.priority,
      newValue: changeUpdated.entity.data.priority,
    },
    {
      changeAuditEntity: ENTITY_ID,
      entityId: changeUpdated.entity.id,
      entityType: changeUpdated.entity.type,
      userId: changeUpdated.user.id,
      userEmail: changeUpdated.user.email,
      userDisplayName: changeUpdated.user.displayName,
      fieldName: 'list',
      oldValue: JSON.stringify(changeInitial.entity.data.list),
      newValue: JSON.stringify(changeUpdated.entity.data.list),
    },
  ];

  const mockEntityManager = {
    flush: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
    persist: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
    persistAndFlush: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
  };

  const mockChangeAuditEntityRepository = {
    create: jest.fn().mockImplementation(() => {
      return createdEntity;
    }),
    findOne: jest.fn(),
  };

  const mockChangeAuditChangeRepository = {
    create: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CreateChangeAuditChangeService,
        {
          provide: getRepositoryToken(ChangeAuditChange),
          useValue: mockChangeAuditChangeRepository,
        },
        {
          provide: getRepositoryToken(ChangeAuditEntity),
          useValue: mockChangeAuditEntityRepository,
        },
        {
          provide: EntityManager,
          useValue: mockEntityManager,
        },
      ],
    }).compile();

    service = module.get<CreateChangeAuditChangeService>(CreateChangeAuditChangeService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should insert the initial version of an entity', async () => {
    when(mockChangeAuditEntityRepository.findOne)
      .calledWith(
        {
          entityId: changeInitial.entity.id,
          appId: changeInitial.appId,
        },
        {
          orderBy: { createdAt: -1 },
        },
      )
      .mockImplementation(() => {
        return Promise.resolve(null);
      });

    when(mockChangeAuditEntityRepository.create)
      .calledWith(CHANGE_INITIAL_DATA)
      .mockImplementation(() => {
        return Promise.resolve(createdEntity);
      });

    await service.createChange(changeInitial);

    expect(mockChangeAuditEntityRepository.findOne).toHaveBeenCalledTimes(1);
    expect(mockChangeAuditEntityRepository.create).toHaveBeenCalledTimes(1);
    expect(mockEntityManager.persistAndFlush).toHaveBeenCalledTimes(1);
  });

  it('should not create changes for the initial version of an entity', async () => {
    when(mockChangeAuditEntityRepository.findOne)
      .calledWith(
        {
          entityId: changeInitial.entity.id,
          appId: changeInitial.appId,
        },
        {
          orderBy: { createdAt: -1 },
        },
      )
      .mockImplementation(() => {
        return Promise.resolve(null);
      });

    when(mockChangeAuditEntityRepository.create)
      .calledWith(CHANGE_INITIAL_DATA)
      .mockImplementation(() => {
        return Promise.resolve(createdEntity);
      });

    await service.createChange(changeInitial);

    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledTimes(2);
    expect(mockEntityManager.persist).toHaveBeenCalledTimes(2);
    expect(mockEntityManager.flush).toHaveBeenCalledTimes(2);
  });

  it('should insert correct changes for an updated entity', async () => {
    when(mockChangeAuditEntityRepository.findOne)
      .calledWith(
        {
          appId: changeUpdated.appId,
          entityId: changeUpdated.entity.id,
          entityType: changeUpdated.entity.type,
        },
        {
          orderBy: { createdAt: -1 },
        },
      )
      .mockImplementation(() => {
        return Promise.resolve(createdEntity);
      });

    when(mockChangeAuditEntityRepository.create)
      .calledWith(CHANGE_UPDATED_DATA)
      .mockImplementation(() => {
        return Promise.resolve(updatedEntity);
      });

    createdEntity.entity = JSON.parse(createdEntity.entity);
    updatedEntity.entity = JSON.parse(updatedEntity.entity);
    await service.createChange(changeUpdated);

    expect(mockChangeAuditEntityRepository.findOne).toHaveBeenCalled();
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledTimes(8);
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledWith(CHANGES[0]);
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledWith(CHANGES[1]);
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledWith(CHANGES[2]);
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledWith(CHANGES[3]);
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledWith(CHANGES[4]);
    expect(mockChangeAuditChangeRepository.create).toHaveBeenCalledWith(CHANGES[5]);
    expect(mockEntityManager.persist).toHaveBeenCalledTimes(8);
    expect(mockEntityManager.flush).toHaveBeenCalledTimes(3);
  });
});
