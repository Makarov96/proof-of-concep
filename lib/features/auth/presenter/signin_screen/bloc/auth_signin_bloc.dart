import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';

class AuthSignInBloc extends StateNotifier<AsyncValue<bool?>> {
  AuthSignInBloc({required this.ref})
      : super(
          const AsyncData(
            null,
          ),
        );

  final Ref ref;

  Future<void> signIn() async {
    final userEntity = ref.read(sigInFormNotifier.notifier);
    final authRepository = ref.read(authProvider);
    state = const AsyncValue.loading();
    final either = await authRepository.logIn(
      email: userEntity.email,
      password: userEntity.password,
    );
    var (f, data) = either;
    if (f == null) {
      state = AsyncValue.data(data);
    } else {
      state = AsyncValue.error(f.message ?? '', StackTrace.current);
    }
    userEntity.reset();
  }
}
