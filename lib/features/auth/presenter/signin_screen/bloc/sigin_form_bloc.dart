import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInFormBloc extends StateNotifier<AsyncValue<void>> {
  SignInFormBloc({required this.ref})
      : super(
          const AsyncData(
            null,
          ),
        );

  final Ref ref;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void reset() {
    emailController.clear();
    passwordController.clear();
    passwordController.clearComposing();
    emailController.clearComposing();
  }

  String get password => passwordController.text;
  String get email => emailController.text;
}
