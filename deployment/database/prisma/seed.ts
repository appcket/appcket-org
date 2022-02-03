import { PrismaClient, Prisma } from '@prisma/client';

const prisma = new PrismaClient();

const organizationData: Prisma.organizationCreateInput[] = [
  {
    organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
    name: 'Vandelay Industries',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
  {
    organization_id: '5fb17fd4-9292-4e20-bfa7-809d1a62fcc7',
    name: 'Pennypacker Enterprises',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
];

const organizationUserData: Prisma.organization_userCreateInput[] = [
  {
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
    user_id: '4379775d-7629-4dca-9dd0-8781329569b1',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
  {
    organization: {
      connect: {
        organization_id: '5fb17fd4-9292-4e20-bfa7-809d1a62fcc7',
      },
    },
    user_id: '4379775d-7629-4dca-9dd0-8781329569b1',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
  {
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
    user_id: '18b24af2-ef61-4fcc-a1e0-b27bbc4f6a2d',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
  {
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
    user_id: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
  {
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
    user_id: 'ff88829c-0226-44f3-9eb2-6e294ccd57d3',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
  {
    organization: {
      connect: {
        organization_id: '5fb17fd4-9292-4e20-bfa7-809d1a62fcc7',
      },
    },
    user_id: '6dde7b5b-ffe1-4627-9ca9-d4c5290f6f20',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
  },
];

const taskStatusTypeData: Prisma.task_status_typeCreateInput[] = [
  {
    task_status_type_id: '272892f2-f03b-4c33-94e0-a5ed27f9e2df',
    name: 'Incomplete',
  },
  {
    task_status_type_id: '34987d28-089e-4f21-bc93-2fd1827107d4',
    name: 'Doing',
  },
  {
    task_status_type_id: '152892f2-f03b-4c33-94e0-a5ed27f9e2dd',
    name: 'Done',
  },
];

const projectData: Prisma.projectCreateInput[] = [
  {
    project_id: '1cb17fd4-9292-4e20-bfa7-809d1a62fcd5',
    name: 'Latex 3.0',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
  },
  {
    project_id: '2fb17fd4-9292-4e20-bfa7-809d1a62fca4',
    name: 'Project Bosco',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
  },
];

const taskData: Prisma.taskCreateInput[] = [
  {
    name: 'Hire new salesman to help sell Latex 2.0 line',
    description: 'Optional description text notes',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    task_status_type: {
      connect: {
        task_status_type_id: '272892f2-f03b-4c33-94e0-a5ed27f9e2df',
      },
    },
    project: {
      connect: {
        project_id: '1cb17fd4-9292-4e20-bfa7-809d1a62fcd5',
      },
    },
  },
  {
    name: 'Reply to George Costanza and inform him we have decided to go in a different direction',
    description: "George's email is jerkstore@gmail.com",
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    task_status_type: {
      connect: {
        task_status_type_id: '152892f2-f03b-4c33-94e0-a5ed27f9e2dd',
      },
    },
    project: {
      connect: {
        project_id: '2fb17fd4-9292-4e20-bfa7-809d1a62fca4',
      },
    },
  },
  {
    name: 'Research new materials for super secret Latex 3.0 line',
    description: 'TOP SECRET, require NDAs from everybody you speak with',
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    task_status_type: {
      connect: {
        task_status_type_id: '272892f2-f03b-4c33-94e0-a5ed27f9e2df',
      },
    },
    project: {
      connect: {
        project_id: '2fb17fd4-9292-4e20-bfa7-809d1a62fca4',
      },
    },
  },
];

const teamData: Prisma.teamCreateInput[] = [
  {
    team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
    name: 'Sales',
    created_at: new Date(),
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
  },
  {
    team_id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
    name: 'Manufacturing',
    created_at: new Date(),
    created_by: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    organization: {
      connect: {
        organization_id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      },
    },
  },
];

const teamUserData: Prisma.team_userCreateInput[] = [
  {
    user_id: '4379775d-7629-4dca-9dd0-8781329569b1',
    team: {
      connect: {
        team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      },
    },
  },
  {
    user_id: '18b24af2-ef61-4fcc-a1e0-b27bbc4f6a2d',
    team: {
      connect: {
        team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      },
    },
  },
  {
    user_id: 'cd88e2db-00bb-474f-91d2-2096e10f86a1',
    team: {
      connect: {
        team_id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      },
    },
  },
  {
    user_id: 'ff88829c-0226-44f3-9eb2-6e294ccd57d3',
    team: {
      connect: {
        team_id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
      },
    },
  },
  {
    user_id: '6dde7b5b-ffe1-4627-9ca9-d4c5290f6f20',
    team: {
      connect: {
        team_id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
      },
    },
  },
];

async function main() {
  console.log(`Start seeding ...`);

  for (const organization of organizationData) {
    await prisma.organization.create({
      data: organization,
    });
    console.log(`Created organization with name: ${organization.name}`);
  }

  for (const organizationUser of organizationUserData) {
    await prisma.organization_user.create({
      data: organizationUser,
    });
    console.log(`Created organizationUser with id: ${organizationUser.organization_user_id}`);
  }

  for (const project of projectData) {
    await prisma.project.create({
      data: project,
    });
    console.log(`Created project with name: ${project.name}`);
  }

  for (const taskStatusType of taskStatusTypeData) {
    await prisma.task_status_type.create({
      data: taskStatusType,
    });
    console.log(`Created taskStatusType with name: ${taskStatusType.name}`);
  }

  for (const task of taskData) {
    await prisma.task.create({
      data: task,
    });
    console.log(`Created task with name: ${task.name}`);
  }

  for (const team of teamData) {
    await prisma.team.create({
      data: team,
    });
    console.log(`Created team with name: ${team.name}`);
  }

  for (const teamUser of teamUserData) {
    await prisma.team_user.create({
      data: teamUser,
    });
    console.log(`Created teamUser with id: ${teamUser.team_user_id}`);
  }

  console.log(`Seeding finished.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
