import 'package:just_in_play_proof/core/core_config/country/domain/entity/entity.dart';
import 'package:just_in_play_proof/core/error/error.dart';

abstract class CountryRepository {
  Future<(JustInPLayException?, List<Country>)> getCountry();
}
