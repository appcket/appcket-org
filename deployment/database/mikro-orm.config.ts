import fs from 'fs';
import { Options } from '@mikro-orm/core';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { SeedManager } from '@mikro-orm/seeder';

import { ChangeAuditApp } from './entities/ChangeAuditApp';
import { ChangeAuditChange } from './entities/ChangeAuditChange';
import { ChangeAuditEntity } from './entities/ChangeAuditEntity';
import { ChangeAuditOperationType } from './entities/ChangeAuditOperationType';
import { Organization } from './entities/Organization';
import { OrganizationUser } from './entities/OrganizationUser';
import { Project } from './entities/Project';
import { ProjectUser } from './entities/ProjectUser';
import { Task } from './entities/Task';
import { TaskStatusType } from './entities/TaskStatusType';
import { Team } from './entities/Team';
import { TeamUser } from './entities/TeamUser';

const config: Options = {
  entities: [
    ChangeAuditApp,
    ChangeAuditChange,
    ChangeAuditEntity,
    ChangeAuditOperationType,
    Organization,
    OrganizationUser,
    Project,
    ProjectUser,
    Task,
    TaskStatusType,
    Team,
    TeamUser
  ],
  dbName: 'appcket',
  schema: 'appcket',
  driver: PostgreSqlDriver,
  user: 'dbuser',
  password: 'Ch@ng3To@StrongP@ssw0rd',
  host: 'localhost',
  port: 5432,
  debug: true,
  extensions: [SeedManager],
  seeder: {
    pathTs: './seeders', // path to the folder with seeders
    defaultSeeder: 'DatabaseSeeder', // default seeder class name
    glob: '!(*.d).{js,ts}',
    emit: 'ts', // seeder generation mode
    fileName: (className: string) => className, // seeder file naming convention
  },
  schemaGenerator: {
    disableForeignKeys: false,
  },
  // you may need to enable ssl for your production connection
  // driverOptions: {
  //   connection: {
  //     ssl: {
  //       ca: fs.readFileSync('./ca-certificate.crt'),
  //     }
  //   }
  // }
};

export default config;