export default interface CreateTaskInput {
  name: string;
  description: string;
  taskStatusTypeId: string;
  projectId: string;
  assignedTo: string;
}
