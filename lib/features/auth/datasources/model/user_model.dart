import 'dart:convert';

import 'package:just_in_play_proof/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.userName,
    required super.phoneNumber,
    required super.uuid,
    required super.authStatus,
    required super.userRoll,
    required super.country,
    required super.favoriteSport,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'uuid': uuid});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'userName': userName});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'authStatus': authStatus.name});
    result.addAll({'userRoll': userRoll.name});
    result.addAll({'country': country});
    result.addAll({'favoriteSport': favoriteSport});
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        userName: map['userName'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        uuid: map['uuid'] ?? '',
        authStatus: (map['authStatus'] ?? '').toString().toAuthStatus,
        userRoll: (map['userRoll'] ?? '').toString().toUserRoll,
        country: map['country'] ?? '',
        favoriteSport: map['favoriteSport'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
