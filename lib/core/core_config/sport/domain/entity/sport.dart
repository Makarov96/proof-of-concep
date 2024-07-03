import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final String name;
  const Sport({
    required this.name,
  });
  @override
  List<Object> get props => [name];

  static List<Sport> get listGenerate => const [
        Sport(name: "Soccer"),
        Sport(name: "Basketball"),
        Sport(name: "Tennis"),
        Sport(name: "Golf"),
        Sport(name: "Volleyball"),
        Sport(name: "Swimming"),
        Sport(name: "Baseball"),
        Sport(name: "Ice Hockey"),
        Sport(name: "Table Tennis"),
        Sport(name: "Badminton"),
        Sport(name: "Athletics"),
        Sport(name: "Boxing"),
        Sport(name: "Wrestling"),
        Sport(name: "Rugby"),
        Sport(name: "Cricket"),
        Sport(name: "Archery"),
        Sport(name: "Fencing"),
        Sport(name: "Skiing"),
        Sport(name: "Snowboarding"),
        Sport(name: "Surfing"),
      ];
}
