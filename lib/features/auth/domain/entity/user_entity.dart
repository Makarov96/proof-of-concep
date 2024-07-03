import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.userName,
    required this.phoneNumber,
    required this.authStatus,
    required this.userRoll,
    required this.country,
    required this.favoriteSport,
    this.uuid,
  });

  final String name;
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;
  final String? uuid;
  final AuthStatus authStatus;
  final UserRoll userRoll;
  final String country;
  final String favoriteSport;

  const UserEntity.mockData()
      : uuid = '',
        name = '',
        email = '',
        password = '',
        userName = '',
        phoneNumber = '',
        authStatus = AuthStatus.undefined,
        userRoll = UserRoll.undefined,
        country = '',
        favoriteSport = '';

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        userName,
        phoneNumber,
        uuid,
        authStatus,
        userRoll,
        country,
      ];
}

enum AuthStatus {
  undefined,
  logged,
  logout,
  noRegister,
  unauthorized,
}

extension UserRollValidation on UserRoll {
  bool get isUser => name == UserRoll.user.name;
  bool get isAdmin => name == UserRoll.administrator.name;
}

extension AuthStatusValidation on AuthStatus {
  bool get isLogged => name == AuthStatus.logged.name;
  bool get isNoRegister => name == AuthStatus.noRegister.name;
  bool get isUnauthorized => name == AuthStatus.unauthorized.name;
}

extension ConvertToAuthStatus on String {
  AuthStatus get toAuthStatus {
    final value = this;
    if (value == AuthStatus.logged.name) {
      return AuthStatus.logged;
    } else if (value == AuthStatus.noRegister.name) {
      return AuthStatus.noRegister;
    } else if (value == AuthStatus.unauthorized.name) {
      return AuthStatus.unauthorized;
    } else if (value == AuthStatus.logout.name) {
      return AuthStatus.logout;
    } else {
      return AuthStatus.undefined;
    }
  }

  UserRoll get toUserRoll {
    if (this == UserRoll.administrator.name) {
      return UserRoll.administrator;
    } else if (this == UserRoll.user.name) {
      return UserRoll.user;
    } else {
      return UserRoll.undefined;
    }
  }
}

enum UserRoll {
  undefined,
  user,
  administrator;
}
