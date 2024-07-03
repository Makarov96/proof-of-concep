import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/common/providers/common_providers.dart';
import 'package:just_in_play_proof/core/third_part/secure_storage/provider/secure_provider.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/response_email_signup.dart';
import 'package:just_in_play_proof/features/auth/datasources/repository/auth_data_source.dart';
import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';
import 'package:just_in_play_proof/features/auth/domain/repository/auth_repository.dart';
import 'package:just_in_play_proof/features/auth/presenter/signin_screen/bloc/auth_signin_bloc.dart';
import 'package:just_in_play_proof/features/auth/presenter/signin_screen/bloc/sigin_form_bloc.dart';

import 'package:just_in_play_proof/features/auth/presenter/signup_screen/bloc/auth_signup_bloc.dart';
import 'package:just_in_play_proof/features/auth/presenter/signup_screen/bloc/signup_form_bloc.dart';
import 'package:just_in_play_proof/features/auth/presenter/splash_screen/bloc/check_user_status_bloc.dart';

final authProvider = Provider<AuthRepository>(
  (ref) => AuthDataSource(
    auth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firebaseFirestoreProvider),
    secureStorage: ref.read(justPlaySecureProvider),
  ),
);

final signUpNotifier =
    StateNotifierProvider<AuthSignUpBloc, AsyncValue<ResponseEmailSignUp?>>(
  (ref) => AuthSignUpBloc(ref: ref),
);

final signInNotifier = StateNotifierProvider<AuthSignInBloc, AsyncValue<bool?>>(
  (ref) => AuthSignInBloc(ref: ref),
);

final sigUpFormNotifier =
    StateNotifierProvider<SignUpFormBloc, AsyncValue<UserEntity?>>(
        (ref) => SignUpFormBloc(ref: ref));

final sigInFormNotifier =
    StateNotifierProvider<SignInFormBloc, AsyncValue<void>>(
        (ref) => SignInFormBloc(ref: ref));

final checkStatusStream =
    StreamNotifierProvider.autoDispose<CheckUserStatusBloc, UserEntity>(
        CheckUserStatusBloc.new);
