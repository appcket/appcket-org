import {
  Entity,
  BaseEntity,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  Column,
  UpdateDateColumn,
} from 'typeorm';

@Entity('team')
export class TeamEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  team_id!: string;

  @Column()
  name!: string;

  @Column()
  organization_id!: string;

  @CreateDateColumn()
  created_at!: Date;

  @UpdateDateColumn()
  effective_at!: Date;
}
