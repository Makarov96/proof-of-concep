import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_in_play_proof/core/common/extension/form_extension.dart';
import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/core/third_part/router/just_play_router.dart';
import 'package:just_in_play_proof/core/third_part/router/routes.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';
import 'package:just_in_play_proof/widgets/button/just_play_button.dart';
import 'package:just_in_play_proof/widgets/inputs/just_play_text_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LayoutSignIp(),
    );
  }
}

class LayoutSignIp extends ConsumerStatefulWidget {
  const LayoutSignIp({super.key});

  @override
  ConsumerState<LayoutSignIp> createState() => _LayoutSignIpState();
}

class _LayoutSignIpState extends ConsumerState<LayoutSignIp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ref.listen(
      signInNotifier,
      (previus, current) {
        if (current.isLoading) {
          return;
        }

        if (current.hasError) {
          final userExist = current.error as JustInPLayException;
          if (userExist is FirebaseError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No se encontro usuario'),
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
        }
      },
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 150),
            child: Column(
              children: [
                const Text(
                  'Iniciar\nSesion',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                JustPlayTextForm(
                  controller:
                      ref.read(sigInFormNotifier.notifier).emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  validator: (val) {
                    if ((val ?? '').isValidEmail) {
                      return 'Ingresa un email valido';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                JustPlayButton(
                  text: 'Confirmar',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    ref.read(signInNotifier.notifier).signIn();
                  },
                ),
                TextButton(
                  onPressed: () =>
                      router.pushReplacementNamed(Routes.signUp.name),
                  child: const Text(
                    'Registrate',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
