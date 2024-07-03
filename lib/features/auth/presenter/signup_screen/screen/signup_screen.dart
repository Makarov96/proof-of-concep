import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_in_play_proof/core/core_config/country/presenter/widgets/country_widget.dart';
import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/core/third_part/router/just_play_router.dart';
import 'package:just_in_play_proof/core/third_part/router/routes.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';
import 'package:just_in_play_proof/widgets/button/just_play_button.dart';
import 'package:just_in_play_proof/widgets/inputs/just_play_text_form.dart';
import 'package:just_in_play_proof/core/common/extension/form_extension.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpLayout(),
    );
  }
}

class SignUpLayout extends ConsumerStatefulWidget {
  const SignUpLayout({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends ConsumerState<SignUpLayout> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ref.listen(
      signUpNotifier,
      (previus, current) {
        if (current.isLoading) {
          return;
        }
        if (current.hasError) {
          final userExist = current.error as JustInPLayException;
          if (userExist is FirebaseError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Usuario ya existe'),
            ));
            return;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ha ocurrido un error vuelve a intentarlo'),
            ));
            return;
          }
        }

        context.pushReplacementNamed(Routes.splash.name);
      },
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
            child: Column(
              children: [
                const Text(
                  'Registrate',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                JustPlayTextForm(
                  controller:
                      ref.read(sigUpFormNotifier.notifier).nameController,
                  hintText: 'Nombre',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z]+|\s"),
                    )
                  ],
                  validator: (val) {
                    if ((val ?? '').isValidName) {
                      return 'Ingresa un nombre valido';
                    } else {
                      return null;
                    }
                  },
                ),
                JustPlayTextForm(
                  controller:
                      ref.read(sigUpFormNotifier.notifier).emailController,
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
                JustPlayTextForm(
                  controller:
                      ref.read(sigUpFormNotifier.notifier).passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                JustPlayTextForm(
                  controller:
                      ref.read(sigUpFormNotifier.notifier).userNameController,
                  hintText: 'Nombre de usuario',
                ),
                JustPlayTextForm(
                  controller: ref
                      .read(sigUpFormNotifier.notifier)
                      .phoneNumberController,
                  keyboardType: TextInputType.phone,
                  hintText: 'Número de telefono',
                  validator: (val) {
                    final safePhoneNumber = val ?? '';
                    if (safePhoneNumber.isEmpty) {
                      return 'Ingresa un numero de telefono';
                    } else if (safePhoneNumber.isValidPhone) {
                      return 'Ingresa un numero de telefono valido';
                    } else {
                      return null;
                    }
                  },
                ),
                CountryWidget(
                  onSelect: ref.read(sigUpFormNotifier.notifier).onChange,
                ),
                ChooseSport(
                  onSelect: ref.read(sigUpFormNotifier.notifier).onChangeSport,
                ),
                const SizedBox(
                  height: 40,
                ),
                JustPlayButton(
                  text: 'Confirmar',
                  onPressed: () {
                    if (_formKey.currentState!.validate() ||
                        ref.read(sigUpFormNotifier.notifier).country == null ||
                        ref.read(sigUpFormNotifier.notifier).sport == null) {
                      return;
                    }
                    ref.read(signUpNotifier.notifier).signUp();
                  },
                ),
                TextButton(
                  onPressed: () =>
                      router.pushReplacementNamed(Routes.signIn.name),
                  child: const Text(
                    'Iniciar Sesion',
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
