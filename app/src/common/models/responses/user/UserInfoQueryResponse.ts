import User from 'src/common/models/User';

export default interface UserInfoQueryResponse extends User {
  userInfo: User;
}
