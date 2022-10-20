export default interface CreateTeamInput {
  name: string;
  description: string;
  organizationId: string;
  userIds: string[];
}
