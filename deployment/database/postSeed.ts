import { MikroORM } from '@mikro-orm/core';
import { EntityManager } from '@mikro-orm/postgresql';

import config from './mikro-orm.config';

(async () => {
  const orm = await MikroORM.init(config);
  const em = orm.em as EntityManager;

  const connection = em.getConnection();

  console.log('Post seed sql commands can be run here if needed');

  await orm.close(true);
})();