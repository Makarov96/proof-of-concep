import 'dart:developer';

import 'package:equatable/equatable.dart';

sealed class JustInPLayException with EquatableMixin implements Exception {
  const JustInPLayException({
    this.message,
    this.preffix,
  });
  final String? message;
  final String? preffix;

  @override
  List<Object?> get props => [message, preffix];
}

class NoIssueDetected extends JustInPLayException {
  const NoIssueDetected();

  const NoIssueDetected.noIssueDetected();
}

class RegisterCredentialError extends JustInPLayException {
  const RegisterCredentialError({
    super.message = 'Credential Invalid',
    super.preffix = '',
  });

  @override
  String toString() => 'NetworkError(message:$message,preffix: $preffix)';
}

class ServerError extends JustInPLayException {
  ServerError({
    super.message = '',
    super.preffix = '',
  }) {
    logger();
  }

  void logger() {
    log(toString());
  }

  @override
  String toString() => 'NetworkError(message:$message,preffix: $preffix)';
}

class NetworkError extends JustInPLayException {
  const NetworkError({
    super.message = '',
    super.preffix = '',
  });

  @override
  String toString() => 'NetworkError(message:$message,preffix: $preffix)';
}

class LocalError extends JustInPLayException {
  const LocalError({
    required super.message,
    required super.preffix,
  });

  @override
  String toString() => 'LocalError(message:$message,preffix: $preffix)';
}

class FirebaseError extends JustInPLayException {
  const FirebaseError({
    required super.message,
    required super.preffix,
  });

  @override
  String toString() => 'FirebaseError(message:$message,preffix: $preffix)';
}

class UserNotExist extends JustInPLayException {
  const UserNotExist({
    super.message = 'Doesnt exist user',
    super.preffix = '0',
  });

  @override
  String toString() => 'UserNotExist(message:$message,preffix: $preffix)';
}
