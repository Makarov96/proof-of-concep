import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/request_email_signup.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/response_email_signup.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';

class AuthSignUpBloc extends StateNotifier<AsyncValue<ResponseEmailSignUp?>> {
  AuthSignUpBloc({required this.ref})
      : super(
          const AsyncData(
            null,
          ),
        );

  final Ref ref;

  Future<void> signUp() async {
    final userEntity = ref.read(sigUpFormNotifier.notifier);
    final authRepository = ref.read(authProvider);
    state = const AsyncValue.loading();
    final either = await authRepository.registerUser(
      request: RequestEmailSignUp(
        userModel: userEntity.userEntity,
      ),
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
