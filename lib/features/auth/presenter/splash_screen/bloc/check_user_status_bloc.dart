import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';
import 'package:just_in_play_proof/features/auth/domain/provider/providers.dart';

class CheckUserStatusBloc extends AutoDisposeStreamNotifier<UserEntity> {
  CheckUserStatusBloc();
  StreamController<UserEntity> streamController =
      StreamController<UserEntity>();

  @override
  Stream<UserEntity> build() async* {
    final auth = ref.read(authProvider);
    final listener = auth.checkUserStatus();
    state = const AsyncValue.loading();
    listener.listen(
      (event) async {
        final (f, data) = event;
        if (f == null) {
          state = AsyncValue.data(data);
        }
      },
    ).onError((error) {
      state = AsyncValue.error(error, StackTrace.current);
    });

    yield* streamController.stream;
  }
}
