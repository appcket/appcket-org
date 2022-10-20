export default interface CreateProjectInput {
  name: string;
  description: string;
  organizationId: string;
  userIds: string[];
}
