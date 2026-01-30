import { EntityManager } from '@mikro-orm/core';
import { Factory, Seeder } from '@mikro-orm/seeder';
import { faker } from '@faker-js/faker';

import { Organization } from '../entities/Organization';
import { OrganizationUser } from '../entities/OrganizationUser';
import { Project } from '../entities/Project';
import { ProjectUser } from '../entities/ProjectUser';
import { Task } from '../entities/Task';
import { TaskStatusType } from '../entities/TaskStatusType';
import { Team } from '../entities/Team';
import { TeamUser } from '../entities/TeamUser';
import { User } from '../entities/User';
import { randomUUID } from 'crypto';

const now = new Date();

export class TeamFactory extends Factory<Team> {
  model = Team;

  definition(): Partial<Team> {
    return {
      id: randomUUID(),
      name: `${faker.company.catchPhraseAdjective()} ${faker.company.catchPhraseDescriptor()}`,
      description: faker.lorem.words(),
    };
  }
}

export class DatabaseSeeder extends Seeder {
  private organizationEntities = [];
  private taskStatusTypeEntities = [];
  private projectEntities = [];
  private teamEntities = [];
  private userEntities: Record<string, User> = {};

  private accountsUsers = {
    art: 'c83ccc8c-2c1f-4a7a-9506-eaf235a284e9',
    kel: '7e2e3888-b370-4309-b82c-403b6871a390',
    he: '83d2fae6-76d9-497c-bbf6-f177785e6195',
    lloyd: 'ba3b17f0-2698-4455-b150-0dcfbf9fdcd8',
    ryan: 'de3127bc-dbe6-4775-9334-2f873f413d23',
  };

  private userData = [
    {
      id: this.accountsUsers.ryan,
      email: 'ryan@appcket.org',
      firstName: 'Ryan',
      lastName: 'Appcket',
      username: 'ryan',
      attributes: { jobTitle: 'Assistant Vice President' },
    },
    {
      id: this.accountsUsers.lloyd,
      email: 'lloyd@appcket.org',
      firstName: 'Lloyd',
      lastName: 'Appcket',
      username: 'lloyd',
      attributes: { jobTitle: 'Systems Engineer' },
    },
    {
      id: this.accountsUsers.art,
      email: 'art@appcket.org',
      firstName: 'Art',
      lastName: 'Vandelay',
      username: 'art',
      attributes: { jobTitle: 'CEO, Vandelay Industries' },
    },
    {
      id: this.accountsUsers.kel,
      email: 'kel@appcket.org',
      firstName: 'Kel',
      lastName: 'Varnsen',
      username: 'kel',
      attributes: { jobTitle: 'Regional Director, Manufacturing' },
    },
    {
      id: this.accountsUsers.he,
      email: 'he@pennypacker.org',
      firstName: 'H.E.',
      lastName: 'Pennypacker',
      username: 'he',
      attributes: { jobTitle: 'Wealthy Industrialist' },
    },
  ];

  private organizationData: Partial<Organization>[] = [
    {
      id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      name: 'Vandelay Industries',
      createdAt: now,
      updatedAt: now,
    },
    {
      id: '5fb17fd4-9292-4e20-bfa7-809d1a62fcc7',
      name: 'Pennypacker Enterprises',
      createdAt: now,
      updatedAt: now,
    },
  ];

  async run(em: EntityManager): Promise<void> {
    console.log(`Start seeding...`);

    for (const data of this.userData) {
      const user = em.create(User, data);
      this.userEntities[data.username] = user;
      console.log(`Created User with username: ${data.username}`);
    }

    const taskStatusTypeData: TaskStatusType[] = [
      {
        id: 'incomplete',
        name: 'Incomplete',
      },
      {
        id: 'doing',
        name: 'Doing',
      },
      {
        id: 'done',
        name: 'Done',
      },
    ];

    for (const entity of taskStatusTypeData) {
      const createdEntity = em.create(TaskStatusType, entity);
      this.taskStatusTypeEntities.push(createdEntity);
      console.log(`Created TaskStatusType with name: ${entity.name}`);
    }

    for (const entity of this.organizationData) {
      const createdEntity = em.create(Organization, entity);
      this.organizationEntities.push(createdEntity);
      console.log(`Created Organization with name: ${entity.name}`);
    }

    const organizationUserData: OrganizationUser[] = [
      {
        id: '02f3593d-aff4-409a-b297-961078a162c7',
        organization: this.organizationEntities[0],
        user: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '12f110b2-eff5-4e38-b1e8-2b23373cdf38',
        organization: this.organizationEntities[0],
        user: this.userEntities.lloyd,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'b67cdfca-6736-4b50-8281-afd2c126572f',
        organization: this.organizationEntities[0],
        user: this.userEntities.art,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'faab3b1d-83e6-412d-90b5-cb3f8af2fd59',
        organization: this.organizationEntities[0],
        user: this.userEntities.kel,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '74bc2775-14e1-42b1-8766-904deb85c6f0',
        organization: this.organizationEntities[1],
        user: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '193110d3-3994-4d24-aa87-73c1b77c7a47',
        organization: this.organizationEntities[1],
        user: this.userEntities.he,
        createdAt: now,
        updatedAt: now,
      },
    ];

    for (const entity of organizationUserData) {
      em.create(OrganizationUser, entity);
      console.log(`Created OrganizationUser with id: ${entity.id}`);
    }

    const projectData: Project [] = [
      {
        id: '1cb17fd4-9292-4e20-bfa7-809d1a62fcd5',
        name: 'Latex 2.0',
        description: 'This project is for tracking things we need for launching our new Latex line.',
        organization: this.organizationEntities[0],
        createdBy: this.userEntities.ryan,
        updatedBy: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '2fb17fd4-9292-4e20-bfa7-809d1a62fca4',
        name: 'Project Bosco',
        description: 'Make sure we choose a stronger password this time.',
        organization: this.organizationEntities[0],
        createdBy: this.userEntities.ryan,
        updatedBy: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '16d93551-dbd0-4a1e-9157-32d036d345ed',
        name: 'Silver Mine #2H Peru Mountains',
        description: 'Mr. Pennypacker wants due diligence performed on whether to invest in a new Peruvian mine.',
        organization: this.organizationEntities[1],
        createdBy: this.userEntities.he,
        updatedBy: this.userEntities.he,
        createdAt: now,
        updatedAt: now,
      }
    ];

    for (const entity of projectData) {
      const createdEntity = em.create(Project, entity);
      this.projectEntities.push(createdEntity);
      console.log(`Created Project with name: ${entity.name}`);
    }

    const projectUserData: ProjectUser[] = [
      {
        id: 'ef70dc8f-cd63-403d-8917-9514e8ec8813',
        user: this.userEntities.ryan,
        project: this.projectEntities[0],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'e2666c68-7696-44db-98ea-f0dd1b6b7750',
        user: this.userEntities.lloyd,
        project: this.projectEntities[0],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '84efee64-2a5b-4c73-81ab-fa012105dd8a',
        user: this.userEntities.art,
        project: this.projectEntities[1],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'c231c884-6998-464d-ab98-7df6a127cec2',
        user: this.userEntities.kel,
        project: this.projectEntities[1],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '31bf6054-5048-479d-975b-4aab115f3d82',
        user: this.userEntities.he,
        project: this.projectEntities[2],
        createdAt: now,
        updatedAt: now,
      },
    ];

    for (const entity of projectUserData) {
      em.create(ProjectUser, entity);
      console.log(`Created ProjectUser with id: ${entity.id}`);
    }

    const teamData: Team[] = [
      {
        id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
        name: 'Sales',
        organization: this.organizationEntities[0],
        createdBy: this.userEntities.ryan,
        updatedBy: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
        name: 'Manufacturing',
        organization: this.organizationEntities[0],
        createdBy: this.userEntities.ryan,
        updatedBy: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      }
    ];

    for (const entity of teamData) {
      const createdEntity = em.create(Team, entity);
      this.teamEntities.push(createdEntity);
      console.log(`Created Team with name: ${entity.name}`);
    }

    new TeamFactory(em).each(team => {
      team.organization = this.organizationEntities[0];
    }).create(25);
    
    new TeamFactory(em).each(team => {
      team.organization = this.organizationEntities[1];
    }).create(25);
    console.log(`Created 50 random Teams`);

    const teamUserData: TeamUser[] = [
      {
        id: '02591293-23a1-4759-a04c-65818ed57238',
        user: this.userEntities.ryan,
        team: this.teamEntities[0],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '14db94b9-7daf-4027-bff4-c9ba580c0e0b',
        user: this.userEntities.lloyd,
        team: this.teamEntities[0],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '7e8845ac-5bd2-40c7-9c8b-4adc7373002b',
        user: this.userEntities.art,
        team: this.teamEntities[1],
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '56b01550-816d-49b9-aeb1-8955d428bd64',
        user: this.userEntities.kel,
        team: this.teamEntities[1],
        createdAt: now,
        updatedAt: now,
      },
    ];

    for (const entity of teamUserData) {
      em.create(TeamUser, entity);
      console.log(`Created TeamUser with id: ${entity.id}`);
    }

    const taskData: Task[] = [
      {
        id: 'e592d49b-e25b-4f7a-bbdd-e058028d4140',
        name: 'Hire new salesman to help sell Latex line',
        description: 'Optional description notes',
        assignedTo: this.userEntities.ryan,
        taskStatusTypeId: this.taskStatusTypeEntities[0],
        projectId: this.projectEntities[0],
        createdBy: this.userEntities.ryan,
        updatedBy: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: '866e4e44-3c0f-4105-beb4-99460ef5cf84',
        name: 'Reply to George Costanza and inform him we have decided to go in a different direction',
        description: "George's email is jerkstore@gmail.com",
        assignedTo: this.userEntities.art,
        taskStatusTypeId: this.taskStatusTypeEntities[2],
        projectId: this.projectEntities[1],
        createdBy: this.userEntities.art,
        updatedBy: this.userEntities.art,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'a15be7c6-6f31-432e-b697-f31e35cc9de3',
        name: 'Research new materials for super secret Latex 2.0 line',
        description: 'TOP SECRET, require NDAs from everybody you speak with',
        assignedTo: this.userEntities.kel,
        taskStatusTypeId: this.taskStatusTypeEntities[0],
        projectId: this.projectEntities[0],
        createdBy: this.userEntities.kel,
        updatedBy: this.userEntities.kel,
        createdAt: now,
        updatedAt: now,
      },
      {
        id: 'cca29503-f4bc-4912-85a5-55f7e5d11fa1',
        name: 'New wardrobe',
        description: 'Before he travels to see the new mine location, Mr. Pennypacker wants some authentic clothing from Putumayo.',
        assignedTo: this.userEntities.ryan,
        taskStatusTypeId: this.taskStatusTypeEntities[0],
        projectId: this.projectEntities[2],
        createdBy: this.userEntities.ryan,
        updatedBy: this.userEntities.ryan,
        createdAt: now,
        updatedAt: now,
      },
    ];

    for (const entity of taskData) {
      em.create(Task, entity);
      console.log(`Created Task with name: ${entity.name}`);
    }
  }
}