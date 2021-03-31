export type Team = {
  team_id: string;
  name: string;
  created_at: Date;
  effective_at: Date;
};

export type TeamNode = {
  node: Team;
};
