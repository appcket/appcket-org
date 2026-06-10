import { Entity, ManyToOne, Unique } from '@mikro-orm/decorators/legacy';
import { Organization } from 'src/organization/organization.entity';
import { User } from 'src/user/user.entity';
import { BaseEntity } from 'src/common/entities/base.entity';

@Entity({ schema: 'appcket', tableName: 'organization_user' })
@Unique({ properties: ['organization', 'user'] })
export class OrganizationUser extends BaseEntity {
  @ManyToOne({
    entity: () => Organization,
    fieldName: 'organization_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  organization!: Organization;

  @ManyToOne({
    entity: () => User,
    fieldName: 'user_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  user!: User;
}
