import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_in_play_proof/core/common/user/user.dart';
import 'package:just_in_play_proof/core/core_config/sign_out/domain/provider/sign_out_provider.dart';
import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/core/third_part/router/routes.dart';

class JustPlayDrawer extends ConsumerStatefulWidget {
  const JustPlayDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JustPlayDrawerState();
}

class _JustPlayDrawerState extends ConsumerState<JustPlayDrawer> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      signOutNotifier,
      (previus, current) {
        if (current.isLoading) {
          return;
        }
        if (current.hasError) {
          final userExist = current.error as JustInPLayException;
          if (userExist is FirebaseError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Error al salir, vuellve a intentarlo'),
            ));
            return;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ha ocurrido un error vuelve a intentarlo'),
            ));
            return;
          }
        } else {
          context.pushReplacementNamed(Routes.splash.name);
          return;
        }
      },
    );
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          const UserInfo(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Consumer(
              builder: (context, ref, child) {
                return TextButton(
                  onPressed: () {
                    ref.read(signOutNotifier.notifier).signOut();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Salir',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          GlobalUser.user?.email ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          GlobalUser.user?.country ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          GlobalUser.user?.favoriteSport ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          GlobalUser.user?.userName ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
