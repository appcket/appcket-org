import { Options } from '@mikro-orm/core';

import { Organization } from './entities/Organization';
import { OrganizationUser } from './entities/OrganizationUser';
import { Project } from './entities/Project';
import { ProjectUser } from './entities/ProjectUser';
import { Task } from './entities/Task';
import { TaskStatusType } from './entities/TaskStatusType';
import { Team } from './entities/Team';
import { TeamUser } from './entities/TeamUser';

const config: Options = {
  entities: [Organization, OrganizationUser, Project, ProjectUser, Task, TaskStatusType, Team, TeamUser],
  dbName: 'appcket',
  schema: 'appcket',
  type: 'postgresql',
  user: 'dbuser',
  password: 'Ch@ng3To@StrongP@ssw0rd',
  host: 'localhost',
  port: 5432,
  debug: true,
  seeder: {
    pathTs: './seeders', // path to the folder with seeders
    defaultSeeder: 'DatabaseSeeder', // default seeder class name
    glob: '!(*.d).{js,ts}',
    emit: 'ts', // seeder generation mode
    fileName: (className: string) => className, // seeder file naming convention
  },
};

export default config;