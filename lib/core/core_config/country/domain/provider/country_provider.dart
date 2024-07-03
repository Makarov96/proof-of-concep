part of '../../presenter/bloc/country_bloc.dart';

final _countrApiProvider = Provider<CountryRepository>(
  (ref) => ApiCountryDataSource(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

final countryNotifier =
    StateNotifierProvider<CountryBloc, AsyncValue<List<Country>>>(
  (ref) => CountryBloc(ref: ref),
);
