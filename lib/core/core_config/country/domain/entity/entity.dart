import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
    required this.flag,
    required this.code,
    required this.country,
  });

  final String flag;
  final String code;
  final String country;

  @override
  List<Object> get props => [
        flag,
        code,
        country,
      ];
}
