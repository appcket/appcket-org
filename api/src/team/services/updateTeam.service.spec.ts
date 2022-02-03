import { Test, TestingModule } from '@nestjs/testing';
import { PrismaService } from 'src/common/services/prisma.service';
import { when } from 'jest-when';

import { UpdateTeamService } from './updateTeam.service';
import { GetTeamService } from './getTeam.service';

// #region mocks
const teamId = '9f107212-ecb8-4a3c-931e-10edaf9af582';

const updateTeamInput = {
  teamId,
  name: 'Updated Team Name',
  organizationId: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
  userIds: ['4379775d-7629-4dca-9dd0-8781329569b1', 'cd88e2db-00bb-474f-91d2-2096e10f86a1'],
};

const oneTeam = {
  team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
  name: 'Updated Team Name',
  organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
  created_at: '2020-10-27T00:00:00.000Z',
  updated_at: '2021-12-24T00:00:00.000Z',
  deleted_at: null,
  created_by: null,
  updated_by: null,
  deleted_by: null,
  team_user: [
    {
      team_user_id: '53d1e59f-716f-4f9c-9289-63e72721e301',
      team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      user_id: '4379775d-7629-4dca-9dd0-8781329569b1',
      created_at: '2020-10-27T00:00:00.000Z',
      updated_at: '2020-10-27T00:00:00.000Z',
      deleted_at: null,
      created_by: null,
      updated_by: null,
      deleted_by: null,
    },
    {
      team_user_id: '3bc5e8e6-bb64-4152-950a-203895b6c86b',
      team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      user_id: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
      created_at: '2021-12-24T00:00:00.000Z',
      updated_at: '2021-12-24T00:00:00.000Z',
      deleted_at: null,
      created_by: null,
      updated_by: null,
      deleted_by: null,
    },
  ],
  organization: {
    organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
    name: 'Vandelay Industries',
    created_at: '2020-10-23T00:00:00.000Z',
    deleted_at: null,
    updated_at: '2020-10-23T00:00:00.000Z',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    updated_by: null,
    deleted_by: null,
  },
};

const updatedTeamUser = {
  team_user_id: '1cabb60c-a5ee-4c7f-9de5-1d42f486b981',
  team_id: updateTeamInput.teamId,
  user_id: updateTeamInput.userIds[1],
  deleted_at: '2021-12-24T00:00:00.000Z',
};

const createdTeamUserId = updateTeamInput.userIds[1];

const teamUsersToDeleteFindManyArgs = {
  where: {
    team_id: updateTeamInput.teamId,
    deleted_at: null,
    user_id: {
      notIn: updateTeamInput.userIds,
    },
  },
  select: {
    team_user_id: true,
  },
};

const existingTeamUsersFindManyArgs = {
  where: {
    team_id: updateTeamInput.teamId,
    deleted_at: null,
    user_id: {
      in: updateTeamInput.userIds,
    },
  },
  select: {
    user_id: true,
  },
};

const createTeamUserArgs = {
  data: {
    team_id: updateTeamInput.teamId,
    user_id: createdTeamUserId,
    created_by: createdTeamUserId,
  },
};

const teamUsersToDelete = [{ team_user_id: '1cabb60c-a5ee-4c7f-9de5-1d42f486b981' }];
const existingTeamUsers = [{ user_id: '4379775d-7629-4dca-9dd0-8781329569b1' }];

const mockPrismaService = {
  team: {
    update: jest.fn().mockResolvedValue(oneTeam),
  },
  team_user: {
    // since the updateTeam service uses findMany() twice, we need to mock those two calls using jest-when to return different data based on different findMany args
    findMany: when(jest.fn())
      .calledWith(teamUsersToDeleteFindManyArgs)
      .mockResolvedValue(teamUsersToDelete)
      .calledWith(existingTeamUsersFindManyArgs)
      .mockResolvedValue(existingTeamUsers),
    // findMany: jest
    //   .fn()
    //   .mockResolvedValueOnce(teamUsersToDelete)
    //   .mockResolvedValueOnce(existingTeamUsers),
    update: jest.fn().mockResolvedValue(updatedTeamUser),
    create: jest.fn(),
  },
};

const mockGetTeamService = {
  getTeam: jest.fn().mockResolvedValue(oneTeam),
};
// #endregion

describe('UpdateTeamService', () => {
  let updateTeamService: UpdateTeamService;
  let prisma: PrismaService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UpdateTeamService,
        {
          provide: PrismaService,
          useValue: mockPrismaService,
        },
        {
          provide: GetTeamService,
          useValue: mockGetTeamService,
        },
      ],
    }).compile();

    updateTeamService = module.get<UpdateTeamService>(UpdateTeamService);
    prisma = module.get<PrismaService>(PrismaService);
    //@ts-ignore
    prisma.team_user.findMany = prisma.team_user.findMany.fn;
  });

  describe('updateTeam', () => {
    it('should create correct team_user records', async () => {
      const createTeamUserSpy = jest.spyOn(prisma.team_user, 'create');
      await updateTeamService.updateTeam(updateTeamInput, createTeamUserArgs.data.user_id);
      expect(createTeamUserSpy).toHaveBeenCalledWith(createTeamUserArgs);
    });
  });
});
