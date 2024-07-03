import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_in_play_proof/core/common/user/user.dart';
import 'package:just_in_play_proof/core/third_part/router/routes.dart';
import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';

//
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      checkStatusStream,
      (previous, next) {
        if (next.isLoading) {
          return;
        }

        if (next.hasError || next.value == null) {
          context.pushReplacementNamed(Routes.signIn.path);
          return;
        }
        final user = next.value!;
        if (!user.authStatus.isLogged) {
          context.pushReplacementNamed(Routes.signIn.path);
          return;
        }

        if (user.userRoll.isUser) {
          GlobalUser.setCurrentUser(user);
          context.pushReplacementNamed(Routes.home.path);
        }
      },
    );
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
