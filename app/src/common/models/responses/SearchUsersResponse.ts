import User from 'src/common/models/User';

export default interface SearchUsersResponse extends User {
  searchUsers: User[];
}
