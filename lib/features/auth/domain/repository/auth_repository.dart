import 'dart:async';

import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/request_email_signup.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/response_email_signup.dart';
import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<(JustInPLayException?, ResponseEmailSignUp)> registerUser(
      {required RequestEmailSignUp request});

  Stream<(JustInPLayException?, UserEntity)> checkUserStatus();

  Future<(JustInPLayException?, bool)> logIn({
    required String email,
    required String password,
  });

  Future<(JustInPLayException?, bool)> logOut();
}
