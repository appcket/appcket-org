import { Test, TestingModule } from '@nestjs/testing';
import { CLICKHOUSE_CLIENT } from 'src/common/modules/clickhouse.module';
import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { UserService } from 'src/user/services/user.service';
import { CommonService } from 'src/common/services/common.service';

describe('EntityHistoryService', () => {
  let service: EntityHistoryService;
  let clickhouseClient: any;
  let userService: UserService;
  let commonService: CommonService;

  const ENTITY_IDS = [
    '65523d2a-f0df-470e-961d-f11958b08d18',
    'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
  ];
  const USER_ID = 'b1f3593d-aff4-409a-b297-961078a162c7';

  const CLICKHOUSE_ROWS = [
    {
      entity_id: '65523d2a-f0df-470e-961d-f11958b08d18',
      created_at: '2023-06-24T18:13:09.000Z',
      updated_at: '2023-06-25T01:27:39.000Z',
      created_by_id: 'de3127bc-dbe6-4775-9334-2f873f413d23',
      updated_by_id: '83d2fae6-76d9-497c-bbf6-f177785e6195',
    },
    {
      entity_id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
      created_at: '2023-07-07T12:55:12.000Z',
      updated_at: '2023-07-07T12:55:12.000Z',
      created_by_id: 'de3127bc-dbe6-4775-9334-2f873f413d23',
      updated_by_id: 'de3127bc-dbe6-4775-9334-2f873f413d23',
    },
  ];

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

  beforeEach(async () => {
    // Mock ClickHouse Client
    clickhouseClient = {
      query: jest.fn(),
    };

    const mockUserService = {
      getUsersByIds: jest.fn().mockResolvedValue(USERS),
    };

    const mockCommonService = {
      getUserDisplayName: jest.fn().mockImplementation((user) => {
        if (!user) return '';
        return user.firstName ? `${user.firstName} ${user.lastName || ''}`.trim() : user.username;
      }),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        EntityHistoryService,
        {
          provide: CLICKHOUSE_CLIENT,
          useValue: clickhouseClient,
        },
        {
          provide: UserService,
          useValue: mockUserService,
        },
        {
          provide: CommonService,
          useValue: mockCommonService,
        },
      ],
    }).compile();

    service = module.get<EntityHistoryService>(EntityHistoryService);
    userService = module.get<UserService>(UserService);
    commonService = module.get<CommonService>(CommonService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get history summary of specified entities', async () => {
    // Mock the query result
    clickhouseClient.query.mockResolvedValue({
      json: jest.fn().mockResolvedValue(CLICKHOUSE_ROWS),
    });

    const result = await service.getEntitiesHistory(ENTITY_IDS, false, USER_ID);

    expect(clickhouseClient.query).toHaveBeenCalledTimes(1);
    // Basic verification of the result structure
    expect(result).toHaveLength(2);
    
    // Check first item
    expect(result[0].id).toBe('65523d2a-f0df-470e-961d-f11958b08d18');
    expect(result[0].createdBy.displayName).toBe('Ryan');
    expect(result[0].updatedBy.displayName).toBe('Horace Pennypacker');
    expect(result[0].createdAt).toBeInstanceOf(Date);
    expect(result[0].updatedAt).toBeInstanceOf(Date);

    // Check second item
    expect(result[1].id).toBe('da31bf7f-b32c-4ef3-83fb-e16ce7781753');
    expect(result[1].createdBy.displayName).toBe('Ryan');
    expect(result[1].updatedBy.displayName).toBe('Ryan');
  });

  it('should return empty array if no entity IDs provided', async () => {
    const result = await service.getEntitiesHistory([], false, USER_ID);
    expect(clickhouseClient.query).not.toHaveBeenCalled();
    expect(result).toEqual([]);
  });
});