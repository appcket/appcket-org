export default interface UpdateProjectMutationInput {
  projectId: string;
  name: string;
  organizationId: string;
  userIds: string[];
}
