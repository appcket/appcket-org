import { EntityManager, wrap } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';

import { ChangeAuditApp } from '../entities/ChangeAuditApp';
import { ChangeAuditOperationType } from '../entities/ChangeAuditOperationType';
import { Organization } from '../entities/Organization';
import { OrganizationUser } from '../entities/OrganizationUser';
import { Project } from '../entities/Project';
import { ProjectUser } from '../entities/ProjectUser';
import { Task } from '../entities/Task';
import { TaskStatusType } from '../entities/TaskStatusType';
import { Team } from '../entities/Team';
import { TeamUser } from '../entities/TeamUser';

export class DatabaseSeeder extends Seeder {
  private changeAuditOperationTypeData: ChangeAuditOperationType[] = [
    {
      id: 'create',
      name: 'Create',
    },
    {
      id: 'read',
      name: 'Read',
    },
    {
      id: 'update',
      name: 'Update',
    },
    {
      id: 'delete',
      name: 'Delete',
    },
  ];

  private accountsUsers = {
    art: 'c83ccc8c-2c1f-4a7a-9506-eaf235a284e9',
    kel: '7e2e3888-b370-4309-b82c-403b6871a390',
    he: '83d2fae6-76d9-497c-bbf6-f177785e6195',
    lloyd: 'ba3b17f0-2698-4455-b150-0dcfbf9fdcd8',
    ryan: 'de3127bc-dbe6-4775-9334-2f873f413d23',
  };

  private organizationData: Organization[] = [
    {
      id: '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      name: 'Vandelay Industries'
    },
    {
      id: '5fb17fd4-9292-4e20-bfa7-809d1a62fcc7',
      name: 'Pennypacker Enterprises',
    },
  ];

  private organizationChangeAuditAppData: ChangeAuditApp[] = [
    {
      id: 'd1f3593d-aff4-409a-b297-961078a162c7',
      organizationId: this.organizationData[0],
      name: 'Appcket'
    },
  ];

  private organizationUserData: OrganizationUser[] = [
    {
      id: '02f3593d-aff4-409a-b297-961078a162c7',
      organizationId: this.organizationData[0],
      userId: this.accountsUsers.ryan
    },
    {
      id: '12f110b2-eff5-4e38-b1e8-2b23373cdf38',
      organizationId: this.organizationData[0],
      userId: this.accountsUsers.lloyd
    },
    {
      id: 'b67cdfca-6736-4b50-8281-afd2c126572f',
      organizationId: this.organizationData[0],
      userId: this.accountsUsers.art
    },
    {
      id: 'faab3b1d-83e6-412d-90b5-cb3f8af2fd59',
      organizationId: this.organizationData[0],
      userId: this.accountsUsers.kel
    },
    {
      id: '74bc2775-14e1-42b1-8766-904deb85c6f0',
      organizationId: this.organizationData[1],
      userId: this.accountsUsers.ryan
    },
    {
      id: '193110d3-3994-4d24-aa87-73c1b77c7a47',
      organizationId: this.organizationData[1],
      userId: this.accountsUsers.he
    },
  ];

  private taskStatusTypeData: TaskStatusType[] = [
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

  private projectData: Project [] = [
    {
      id: '1cb17fd4-9292-4e20-bfa7-809d1a62fcd5',
      name: 'Latex 2.0',
      description: 'This project is for tracking things we need for launching our new Latex line.',
      organizationId: this.organizationData[0]
    },
    {
      id: '2fb17fd4-9292-4e20-bfa7-809d1a62fca4',
      name: 'Project Bosco',
      description: 'Make sure we choose a stronger password this time.',
      organizationId: this.organizationData[0]
    },
    {
      id: '16d93551-dbd0-4a1e-9157-32d036d345ed',
      name: 'Silver Mine #2H Peru Mountains',
      description: 'Mr. Pennypacker wants due diligence performed on whether to invest in a new Peruvian mine.',
      organizationId: this.organizationData[1]
    }
  ];

  private projectUserData: ProjectUser[] = [
    {
      id: 'ef70dc8f-cd63-403d-8917-9514e8ec8813',
      userId: this.accountsUsers.ryan,
      projectId: this.projectData[0],
    },
    {
      id: 'e2666c68-7696-44db-98ea-f0dd1b6b7750',
      userId: this.accountsUsers.lloyd,
      projectId: this.projectData[0],
    },
    {
      id: '84efee64-2a5b-4c73-81ab-fa012105dd8a',
      userId: this.accountsUsers.art,
      projectId: this.projectData[1],
    },
    {
      id: 'c231c884-6998-464d-ab98-7df6a127cec2',
      userId: this.accountsUsers.kel,
      projectId: this.projectData[1],
    },
    {
      id: '31bf6054-5048-479d-975b-4aab115f3d82',
      userId: this.accountsUsers.he,
      projectId: this.projectData[2],
    },
  ];

  private taskData: Task[] = [
    {
      id: 'e592d49b-e25b-4f7a-bbdd-e058028d4140',
      name: 'Hire new salesman to help sell Latex line',
      description: 'Optional description notes',
      assignedTo: this.accountsUsers.ryan,
      taskStatusTypeId: this.taskStatusTypeData[0],
      projectId: this.projectData[0]
    },
    {
      id: '866e4e44-3c0f-4105-beb4-99460ef5cf84',
      name: 'Reply to George Costanza and inform him we have decided to go in a different direction',
      description: "George's email is jerkstore@gmail.com",
      assignedTo: this.accountsUsers.art,
      taskStatusTypeId: this.taskStatusTypeData[2],
      projectId: this.projectData[1]
    },
    {
      id: 'a15be7c6-6f31-432e-b697-f31e35cc9de3',
      name: 'Research new materials for super secret Latex 2.0 line',
      description: 'TOP SECRET, require NDAs from everybody you speak with',
      assignedTo: this.accountsUsers.kel,
      taskStatusTypeId: this.taskStatusTypeData[0],
      projectId: this.projectData[0]
    },
    {
      id: 'cca29503-f4bc-4912-85a5-55f7e5d11fa1',
      name: 'New wardrobe',
      description: 'Before he travels to see the new mine location, Mr. Pennypacker wants some authentic clothing from Putumayo.',
      assignedTo: this.accountsUsers.ryan,
      taskStatusTypeId: this.taskStatusTypeData[0],
      projectId: this.projectData[2]
    },
  ];

  private teamData: Team[] = [
    {
      id: '9f107212-ecb8-4a3c-931e-10edaf9af582',
      name: 'Sales',
      organizationId: this.organizationData[0]
    },
    {
      id: 'da31bf7f-b32c-4ef3-83fb-e16ce7781753',
      name: 'Manufacturing',
      organizationId: this.organizationData[0]
    }
  ];

  private teamUserData: TeamUser[] = [
    {
      id: '02591293-23a1-4759-a04c-65818ed57238',
      userId: this.accountsUsers.ryan,
      teamId: this.teamData[0],
    },
    {
      id: '14db94b9-7daf-4027-bff4-c9ba580c0e0b',
      userId: this.accountsUsers.lloyd,
      teamId: this.teamData[0],
    },
    {
      id: '7e8845ac-5bd2-40c7-9c8b-4adc7373002b',
      userId: this.accountsUsers.art,
      teamId: this.teamData[1],
    },
    {
      id: '56b01550-816d-49b9-aeb1-8955d428bd64',
      userId: this.accountsUsers.kel,
      teamId: this.teamData[1],
    },
  ];

  async run(em: EntityManager): Promise<void> {
    console.log(`Start seeding...`);

    for (const entity of this.changeAuditOperationTypeData) {
      em.create(ChangeAuditOperationType, entity);
      console.log(`Created ChangeAuditOperationType with name: ${entity.name}`);
    }

    for (const entity of this.organizationData) {
      em.create(Organization, entity);
      console.log(`Created Organization with name: ${entity.name}`);
    }

    for (const entity of this.organizationChangeAuditAppData) {
      em.create(ChangeAuditApp, entity, { managed: true });
      console.log(`Created ChangeAuditApp with id: ${entity.id}`);
    }

    for (const entity of this.projectData) {
      em.create(Project, entity, { managed: true });
      console.log(`Created Project with name: ${entity.name}`);
    }

    for (const entity of this.teamData) {
      em.create(Team, entity, { managed: true });
      console.log(`Created Team with name: ${entity.name}`);
    }

    for (const entity of this.taskStatusTypeData) {
      em.create(TaskStatusType, entity);
      console.log(`Created TaskStatusType with name: ${entity.name}`);
    }

    for (const entity of this.taskData) {
      em.create(Task, entity, { managed: true });
      console.log(`Created Task with name: ${entity.name}`);
    }

    for (const entity of this.organizationUserData) {
      em.create(OrganizationUser, entity, { managed: true });
      console.log(`Created OrganizationUser with id: ${entity.id}`);
    }

    for (const entity of this.teamUserData) {
      em.create(TeamUser, entity, { managed: true });
      console.log(`Created TeamUser with id: ${entity.id}`);
    }

    for (const entity of this.projectUserData) {
      em.create(ProjectUser, entity, { managed: true });
      console.log(`Created ProjectUser with id: ${entity.id}`);
    }
  }
}