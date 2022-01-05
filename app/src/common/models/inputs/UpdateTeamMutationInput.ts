export default interface UpdateTeamMutationInput {
  teamId: string;
  name: string;
  organizationId: string;
  userIds: string[];
}
