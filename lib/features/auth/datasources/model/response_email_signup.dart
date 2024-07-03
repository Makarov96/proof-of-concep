import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';

class ResponseEmailSignUp {
  const ResponseEmailSignUp({
    required this.user,
  });
  final UserEntity user;

  const ResponseEmailSignUp.mockIssue()
      : user = const UserEntity(
          name: '',
          email: '',
          password: '',
          userName: '',
          phoneNumber: '',
          uuid: '',
          country: '',
          authStatus: AuthStatus.undefined,
          userRoll: UserRoll.undefined,
          favoriteSport: '',
        );
}
