import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';

class RequestEmailSignUp {
  final UserEntity userModel;

  RequestEmailSignUp({
    required this.userModel,
  });

  bool get validation =>
      userModel.email.isNotEmpty ||
      userModel.name.isNotEmpty ||
      userModel.password.isNotEmpty;
}
