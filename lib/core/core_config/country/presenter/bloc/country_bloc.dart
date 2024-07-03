import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/common/providers/common_providers.dart';
import 'package:just_in_play_proof/core/core_config/country/datasources/api/api_country_data_source.dart';
import 'package:just_in_play_proof/core/core_config/country/domain/entity/entity.dart';
import 'package:just_in_play_proof/core/core_config/country/domain/repository/country_repository.dart';

part '../../domain/provider/country_provider.dart';

class CountryBloc extends StateNotifier<AsyncValue<List<Country>>> {
  CountryBloc({required this.ref})
      : super(
          const AsyncData([]),
        ) {
    getAllCountry();
  }
  final Ref ref;
  Future<void> getAllCountry() async {
    final getCountries = ref.read(_countrApiProvider);
    state = const AsyncLoading();
    final either = await getCountries.getCountry();

    var (f, data) = either;
    if (f == null) {
      state = AsyncValue.data(data);
    } else {
      state = AsyncValue.error(f.message ?? '', StackTrace.current);
    }
  }
}
