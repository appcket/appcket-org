import { MikroORM } from '@mikro-orm/core';
import { EntityManager } from '@mikro-orm/postgresql';

import config from './mikro-orm.config';

(async () => {
  const orm = await MikroORM.init(config);
  const em = orm.em as EntityManager;

  const connection = em.getConnection();

  await connection.execute('DROP TABLE IF EXISTS appcket.base_entity;');

  // add foreign keys to keycloak user_entity table after setting everything else up through mikro-orm
  await connection.execute('ALTER TABLE appcket.organization_user ADD CONSTRAINT organization_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.project_user ADD CONSTRAINT project_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.team_user ADD CONSTRAINT team_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.task ADD CONSTRAINT task_assigned_to_foreign FOREIGN KEY (assigned_to) REFERENCES keycloak.user_entity(id);');

  await connection.execute('ALTER TABLE appcket.organization ADD CONSTRAINT task_created_by_foreign FOREIGN KEY (created_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.organization ADD CONSTRAINT task_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.organization ADD CONSTRAINT task_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES keycloak.user_entity(id);');

  await connection.execute('ALTER TABLE appcket.project ADD CONSTRAINT task_created_by_foreign FOREIGN KEY (created_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.project ADD CONSTRAINT task_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.project ADD CONSTRAINT task_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES keycloak.user_entity(id);');

  await connection.execute('ALTER TABLE appcket.team ADD CONSTRAINT task_created_by_foreign FOREIGN KEY (created_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.team ADD CONSTRAINT task_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.team ADD CONSTRAINT task_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES keycloak.user_entity(id);');

  await connection.execute('ALTER TABLE appcket.task ADD CONSTRAINT task_created_by_foreign FOREIGN KEY (created_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.task ADD CONSTRAINT task_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES keycloak.user_entity(id);');
  await connection.execute('ALTER TABLE appcket.task ADD CONSTRAINT task_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES keycloak.user_entity(id);');

  console.log('completed user foreign keys');

  await orm.close(true);
})();