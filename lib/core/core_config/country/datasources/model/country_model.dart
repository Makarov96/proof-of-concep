import 'dart:convert';

import 'package:just_in_play_proof/core/core_config/country/domain/entity/entity.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.flag,
    required super.code,
    required super.country,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'flag': flag});
    result.addAll({'code': code});
    result.addAll({'country': country});

    return result;
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      flag: map['flag'] ?? '',
      code: map['code'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source));
}
