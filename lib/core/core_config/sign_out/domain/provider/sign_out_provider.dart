import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/core_config/sign_out/presenter/bloc/sign_out_bloc.dart';

final signOutNotifier = StateNotifierProvider<SignOutBloc, AsyncValue<bool?>>(
  (ref) => SignOutBloc(ref: ref),
);
