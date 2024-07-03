import 'dart:async';
import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/core/third_part/secure_storage/just_play_secure_storage.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/request_email_signup.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/response_email_signup.dart';
import 'package:just_in_play_proof/features/auth/datasources/model/user_model.dart';
import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';
import 'package:just_in_play_proof/features/auth/domain/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource extends AuthRepository {
  AuthDataSource({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required JustPlaySecureStore secureStorage,
  })  : _auth = auth,
        _firestore = firestore,
        _secureStorage = secureStorage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final JustPlaySecureStore _secureStorage;

  @override
  Future<(JustInPLayException?, ResponseEmailSignUp)> registerUser({
    required RequestEmailSignUp request,
  }) async {
    try {
      if (request.validation) {
        final credential = await _auth.createUserWithEmailAndPassword(
          email: request.userModel.email,
          password: request.userModel.password,
        );

        UserModel userModel = UserModel(
          name: request.userModel.name,
          email: credential.user?.email ?? '',
          userName: request.userModel.userName,
          phoneNumber: request.userModel.phoneNumber,
          uuid: credential.user?.uid ?? '',
          password: '',
          authStatus: request.userModel.authStatus,
          userRoll: request.userModel.userRoll,
          country: request.userModel.country,
          favoriteSport: request.userModel.favoriteSport,
        );
        await _firestore
            .collection('users')
            .doc(credential.user?.uid)
            .set(userModel.toMap());

        await _secureStorage.write(
          jpKeys: JustPlaySecureStorageKeys.userId,
          value: credential.user?.uid,
        );

        return (null, ResponseEmailSignUp(user: userModel));
      } else {
        return (
          const RegisterCredentialError(),
          const ResponseEmailSignUp.mockIssue(),
        );
      }
    } catch (e) {
      return (
        ServerError(
          preffix: e.runtimeType.toString(),
          message: e.toString(),
        ),
        const ResponseEmailSignUp.mockIssue(),
      );
    }
  }

  @override
  Stream<(JustInPLayException?, UserEntity)> checkUserStatus() async* {
    try {
      final userId =
          await _secureStorage.read(jpKeys: JustPlaySecureStorageKeys.userId);
      if (userId.isEmpty) {
        yield* Stream.error(
          (
            const UserNotExist(),
            const UserEntity.mockData(),
          ),
        );
      }

      final data = await _firestore
          .collection('users')
          .where('uuid', isEqualTo: userId)
          .get();
      final user = UserModel.fromMap(data.docs.first.data());

      yield* Stream.value((null, user));
    } on FirebaseException catch (e) {
      yield* Stream.error((
        FirebaseError(message: e.message, preffix: e.code),
        const UserEntity.mockData()
      ));
    }
  }

  @override
  Future<(JustInPLayException?, bool)> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _updateData(
        map: {'authStatus': AuthStatus.logged.name},
        find: email,
        field: 'email',
      );
      final userId = await _getUserId(field: 'email', find: email);
      if (!(await _secureStorage.existValue(
          jpKeys: JustPlaySecureStorageKeys.userId))) {
        await _secureStorage.write(
          jpKeys: JustPlaySecureStorageKeys.userId,
          value: userId,
        );
      }
      return (null, true);
    } on FirebaseException catch (e) {
      return (FirebaseError(message: e.message, preffix: e.code), false);
    }
  }

  @override
  Future<(JustInPLayException?, bool)> logOut() async {
    final userId =
        await _secureStorage.read(jpKeys: JustPlaySecureStorageKeys.userId);
    try {
      await _updateData(
        map: {'authStatus': AuthStatus.logout.name},
        find: userId,
        field: 'uuid',
      );
      await _secureStorage.deleteAll();
      return (null, true);
    } on FirebaseException catch (e) {
      return (FirebaseError(message: e.message, preffix: e.code), false);
    }
  }

  Future<void> _updateData({
    required Map<String, dynamic> map,
    required String find,
    required String field,
  }) async {
    final query = await _firestore
        .collection('users')
        .where(field, isEqualTo: find)
        .limit(1)
        .get();

    final collection = _firestore.collection('users');
    final userId = (query.docs.first.data()['uuid'] ?? '');
    collection.doc(userId).update(map);
  }

  Future<String> _getUserId({
    required String find,
    required String field,
  }) async {
    final query = await _firestore
        .collection('users')
        .where(field, isEqualTo: find)
        .limit(1)
        .get();
    final userId = (query.docs.first.data()['uuid'] ?? '');
    return userId;
  }
}
