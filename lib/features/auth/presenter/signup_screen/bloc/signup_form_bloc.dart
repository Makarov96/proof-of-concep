import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/core_config/country/domain/entity/entity.dart';
import 'package:just_in_play_proof/core/core_config/sport/domain/entity/sport.dart';
import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';

class SignUpFormBloc extends StateNotifier<AsyncValue<UserEntity?>> {
  SignUpFormBloc({required this.ref})
      : super(
          const AsyncData(
            null,
          ),
        );

  final Ref ref;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Country? country;
  onChange(Country? value) {
    country = value ?? const Country(flag: '', code: '', country: '');
  }

  Sport? sport;
  onChangeSport(Sport? value) {
    sport = value ?? const Sport(name: '');
  }

  void reset() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    userNameController.clear();
    phoneNumberController.clear();
    country = null;
    sport = null;
  }

  UserEntity get userEntity {
    return UserEntity(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      userName: userNameController.text,
      phoneNumber: phoneNumberController.text,
      authStatus: AuthStatus.logged,
      userRoll: UserRoll.user,
      country: country?.country ?? '',
      favoriteSport: sport?.name ?? '',
    );
  }
}
