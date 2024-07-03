import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';

class SignOutBloc extends StateNotifier<AsyncValue<bool?>> {
  SignOutBloc({required this.ref})
      : super(
          const AsyncData(
            null,
          ),
        );

  final Ref ref;

  Future<void> signOut() async {
    final authRepository = ref.read(authProvider);
    state = const AsyncValue.loading();
    final either = await authRepository.logOut();
    var (f, data) = either;
    if (f == null) {
      state = AsyncValue.data(data);
    } else {
      state = AsyncValue.error(f.message ?? '', StackTrace.current);
    }
  }
}
