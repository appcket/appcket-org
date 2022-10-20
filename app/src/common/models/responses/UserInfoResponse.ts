import User from 'src/common/models/User';

export default interface UserInfoResponse extends User {
  userInfo: User;
}
