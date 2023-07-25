import { Test, TestingModule } from '@nestjs/testing';
import { ConfigService } from '@nestjs/config';
import { when } from 'jest-when';

import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { EntityHistory } from 'src/entityHistory/entityHistory.entity';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { GetChangeAuditChangeService } from 'src/changeAudit/services/getChangeAuditChange.service';
import { GetChangeAuditEntityService } from 'src/changeAudit/services/getChangeAuditEntity.service';
import { UserService } from 'src/user/services/user.service';
import { CommonService } from 'src/common/services/common.service';

describe('EntityHistoryService', () => {
  let service: EntityHistoryService;
  let getChangeAuditEntityService: GetChangeAuditEntityService;
  let getChangeAuditChangeService: GetChangeAuditChangeService;
  let userService: UserService;
  let commonService: CommonService;
  let configService: ConfigService;

  const ENTITY_IDS = [
    '65523d2a-f0df-470e-961d-f11958b08d18',
    'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
    '9f107212-ecb8-4a3c-931e-10edaf9af582',
  ];
  const APP_ID = 'd1f3593d-aff4-409a-b297-961078a162c7';
  const USER_ID = 'b1f3593d-aff4-409a-b297-961078a162c7';

  const RETURNED_ENTITIES = [
    {
      id: '1dd84e06-20da-4765-94ee-392c5a0cf83b',
      createdAt: '2023-06-24T18:13:09.000Z',
      entityId: '65523d2a-f0df-470e-961d-f11958b08d18',
      operationType: { id: 'create' },
      userId: 'de3127bc-dbe6-4775-9334-2f873f413d23',
    },
    {
      id: 'd046ca57-f77d-4181-b3af-d9244ce02dc7',
      createdAt: '2023-06-25T01:27:39.000Z',
      entityId: '65523d2a-f0df-470e-961d-f11958b08d18',
      operationType: { id: 'update' },
      userId: '83d2fae6-76d9-497c-bbf6-f177785e6195',
    },
    {
      id: '627c49c3-362d-4360-9939-8ee1da31d1ce',
      createdAt: '2023-07-07T12:55:12.000Z',
      entityId: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
      operationType: { id: 'update' },
      userId: 'de3127bc-dbe6-4775-9334-2f873f413d23',
    },
    {
      id: 'a0d7e8f7-b5d2-4cb8-baaf-7c6fe40a2b9e',
      createdAt: '2023-07-07T12:55:49.000Z',
      entityId: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      operationType: { id: 'update' },
      userId: 'de3127bc-dbe6-4775-9334-2f873f413d23',
    },
  ];

  const USER_IDS = RETURNED_ENTITIES.map((emtity) => emtity.userId);

  const USERS = [
    {
      id: 'de3127bc-dbe6-4775-9334-2f873f413d23',
      email: 'ryan@appcket.org',
      firstName: 'Ryan',
      username: 'ryan',
      lastName: null,
    },
    {
      id: '83d2fae6-76d9-497c-bbf6-f177785e6195',
      email: 'he@appcket.org',
      firstName: 'Horace',
      lastName: 'Pennypacker',
      username: 'he',
    },
  ];

  /*
    [
      {
        entityId: 'fsdafsda',
        createdAt: '',
        updatedAt: '',
        createdBy: {},
        updatedBy: {},
      }
    ]
  */

  const mockGetChangeAuditEntityService = {
    getChangeAuditEntity: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
    getChangeAuditEntities: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
    getAllChangeAuditEntityVersions: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
  };

  const mockGetChangeAuditChangeService = {
    getChangeAuditChanges: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
  };

  const mockUserService = {
    getUser: jest.fn().mockImplementation(() => {
      return Promise.resolve();
    }),
    getUsersByIds: jest.fn().mockImplementation(() => {
      return USER_IDS;
    }),
  };

  const mockConfigService = {
    get: jest.fn().mockImplementation(() => {
      return APP_ID;
    }),
  };

  const mockCommonService = {
    getUserDisplayName: jest.fn().mockImplementation(() => {
      return 'Test User';
    }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        EntityHistoryService,
        {
          provide: GetChangeAuditEntityService,
          useValue: mockGetChangeAuditEntityService,
        },
        {
          provide: GetChangeAuditChangeService,
          useValue: mockGetChangeAuditChangeService,
        },
        {
          provide: UserService,
          useValue: mockUserService,
        },
        {
          provide: ConfigService,
          useValue: mockConfigService,
        },
        {
          provide: CommonService,
          useValue: mockCommonService,
        },
      ],
    }).compile();

    service = module.get<EntityHistoryService>(EntityHistoryService);
    getChangeAuditEntityService = module.get<GetChangeAuditEntityService>(
      GetChangeAuditEntityService,
    );
    userService = module.get<UserService>(UserService);
    commonService = module.get<CommonService>(CommonService);
    configService = module.get<ConfigService>(ConfigService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get history of specified entities', async () => {
    when(mockGetChangeAuditEntityService.getChangeAuditEntities)
      .calledWith(APP_ID, ENTITY_IDS)
      .mockImplementation(() => {
        return Promise.resolve(RETURNED_ENTITIES);
      });

    when(mockUserService.getUsersByIds)
      .calledWith(USER_IDS)
      .mockImplementation(() => {
        return Promise.resolve(USERS);
      });

    const result = [
      {
        id: '65523d2a-f0df-470e-961d-f11958b08d18',
        createdAt: '2023-06-24T18:13:09.000Z',
        createdBy: { id: 'de3127bc-dbe6-4775-9334-2f873f413d23', displayName: 'Test User' },
        updatedAt: '2023-06-25T01:27:39.000Z',
        updatedBy: { id: '83d2fae6-76d9-497c-bbf6-f177785e6195', displayName: 'Test User' },
      },
      {
        id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
        createdAt: null,
        createdBy: null,
        updatedAt: '2023-07-07T12:55:12.000Z',
        updatedBy: { id: 'de3127bc-dbe6-4775-9334-2f873f413d23', displayName: 'Test User' },
      },
      {
        id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
        createdAt: null,
        createdBy: null,
        updatedAt: '2023-07-07T12:55:49.000Z',
        updatedBy: { id: 'de3127bc-dbe6-4775-9334-2f873f413d23', displayName: 'Test User' },
      },
    ];
    jest.spyOn(configService, 'get').mockImplementation(() => APP_ID);

    expect(await service.getEntitiesHistory(ENTITY_IDS, false, USER_ID)).toStrictEqual(result);
  });
});
