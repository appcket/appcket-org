import User from '../User';

export default interface UserInfoQueryResponse extends User {
  userInfo: User;
}
