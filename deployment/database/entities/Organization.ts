import { Entity, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';

@Entity({ schema: 'appcket' })
export class Organization extends BaseEntity{
  @Property({ length: 30 })
  name!: string;
}
