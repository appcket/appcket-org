import { Test, TestingModule } from '@nestjs/testing';
import { PrismaService } from 'src/common/services/prisma.service';
import { when } from 'jest-when';

import { UpdateProjectService } from './updateProject.service';
import { GetProjectService } from './getProject.service';

// #region mocks
const projectId = '9f107212-ecb8-4a3c-931e-10edaf9af582';

const updateProjectInput = {
  projectId,
  name: 'Updated Project Name',
  organizationId: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
  userIds: ['4379775d-7629-4dca-9dd0-8781329569b1', 'cd88e2db-00bb-474f-91d2-2096e10f86a1'],
};

const oneProject = {
  project_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
  name: 'Updated Project Name',
  organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
  created_at: '2020-10-27T00:00:00.000Z',
  updated_at: '2021-12-24T00:00:00.000Z',
  deleted_at: null,
  created_by: null,
  updated_by: null,
  deleted_by: null,
  project_user: [
    {
      project_user_id: '53d1e59f-716f-4f9c-9289-63e72721e301',
      project_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      user_id: '4379775d-7629-4dca-9dd0-8781329569b1',
      created_at: '2020-10-27T00:00:00.000Z',
      updated_at: '2020-10-27T00:00:00.000Z',
      deleted_at: null,
      created_by: null,
      updated_by: null,
      deleted_by: null,
    },
    {
      project_user_id: '3bc5e8e6-bb64-4152-950a-203895b6c86b',
      project_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
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

const updatedProjectUser = {
  project_user_id: '1cabb60c-a5ee-4c7f-9de5-1d42f486b981',
  project_id: updateProjectInput.projectId,
  user_id: updateProjectInput.userIds[1],
  deleted_at: '2021-12-24T00:00:00.000Z',
};

const createdProjectUserId = updateProjectInput.userIds[1];

const projectUsersToDeleteFindManyArgs = {
  where: {
    project_id: updateProjectInput.projectId,
    deleted_at: null,
    user_id: {
      notIn: updateProjectInput.userIds,
    },
  },
  select: {
    project_user_id: true,
  },
};

const existingProjectUsersFindManyArgs = {
  where: {
    project_id: updateProjectInput.projectId,
    deleted_at: null,
    user_id: {
      in: updateProjectInput.userIds,
    },
  },
  select: {
    user_id: true,
  },
};

const createProjectUserArgs = {
  data: {
    project_id: updateProjectInput.projectId,
    user_id: createdProjectUserId,
    created_by: createdProjectUserId,
  },
};

const projectUsersToDelete = [{ project_user_id: '1cabb60c-a5ee-4c7f-9de5-1d42f486b981' }];
const existingProjectUsers = [{ user_id: '4379775d-7629-4dca-9dd0-8781329569b1' }];

const mockPrismaService = {
  project: {
    update: jest.fn().mockResolvedValue(oneProject),
  },
  project_user: {
    // since the updateProject service uses findMany() twice, we need to mock those two calls using jest-when to return different data based on different findMany args
    findMany: when(jest.fn())
      .calledWith(projectUsersToDeleteFindManyArgs)
      .mockResolvedValue(projectUsersToDelete)
      .calledWith(existingProjectUsersFindManyArgs)
      .mockResolvedValue(existingProjectUsers),
    // findMany: jest
    //   .fn()
    //   .mockResolvedValueOnce(projectUsersToDelete)
    //   .mockResolvedValueOnce(existingProjectUsers),
    update: jest.fn().mockResolvedValue(updatedProjectUser),
    create: jest.fn(),
  },
};

const mockGetProjectService = {
  getProject: jest.fn().mockResolvedValue(oneProject),
};
// #endregion

describe('UpdateProjectService', () => {
  let updateProjectService: UpdateProjectService;
  let prisma: PrismaService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UpdateProjectService,
        {
          provide: PrismaService,
          useValue: mockPrismaService,
        },
        {
          provide: GetProjectService,
          useValue: mockGetProjectService,
        },
      ],
    }).compile();

    updateProjectService = module.get<UpdateProjectService>(UpdateProjectService);
    prisma = module.get<PrismaService>(PrismaService);
    //@ts-ignore
    prisma.project_user.findMany = prisma.project_user.findMany.fn;
  });

  describe('updateProject', () => {
    it('should create correct project_user records', async () => {
      const createProjectUserSpy = jest.spyOn(prisma.project_user, 'create');
      await updateProjectService.updateProject(
        updateProjectInput,
        createProjectUserArgs.data.user_id,
      );
      expect(createProjectUserSpy).toHaveBeenCalledWith(createProjectUserArgs);
    });
  });
});
