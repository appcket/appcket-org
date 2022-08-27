import User from 'src/common/models/User';

export default interface SearchUsersQueryResponse extends User {
  searchUsers: User[];
}