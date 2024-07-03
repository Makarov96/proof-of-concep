import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';

class GlobalUser {
  GlobalUser._private();
  static final GlobalUser _instance = GlobalUser._private();

  factory GlobalUser() => _instance;

  static UserEntity? user;
  static void setCurrentUser(UserEntity? value) {
    user = value;
  }
}
