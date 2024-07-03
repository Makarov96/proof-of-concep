import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/core_config/country/domain/entity/entity.dart';
import 'package:just_in_play_proof/core/core_config/country/presenter/bloc/country_bloc.dart';
import 'package:just_in_play_proof/core/core_config/sport/domain/entity/sport.dart';
import 'package:just_in_play_proof/widgets/dropwon/dropwon_option.dart';
import 'package:just_in_play_proof/widgets/dropwon/just_play_dropdown.dart';

typedef OnSelect = Function(Country?);
typedef OnSelectSport = Function(Sport?);

class CountryWidget extends StatelessWidget {
  const CountryWidget({
    super.key,
    required this.onSelect,
  });
  final OnSelect onSelect;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (contecx, ref, widget) {
        final countries = ref.watch(countryNotifier);
        return countries.when(
            data: (data) {
              return JustPlayDropDown<Country>(
                onSelect: onSelect,
                label: 'Selecciona un pais',
                options: data
                    .map(
                      (e) => DropDownOption<Country>(
                        value: e,
                        option: e.country,
                        iconPath: e.flag,
                      ),
                    )
                    .toList(),
              );
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const CircularProgressIndicator());
      },
    );
  }
}

class ChooseSport extends StatelessWidget {
  const ChooseSport({
    super.key,
    required this.onSelect,
  });
  final OnSelectSport onSelect;
  @override
  Widget build(BuildContext context) {
    return JustPlayDropDown<Sport>(
      onSelect: onSelect,
      label: 'Selecciona un deporte',
      options: Sport.listGenerate
          .map(
            (e) => DropDownOption<Sport>(
              value: e,
              option: e.name,
            ),
          )
          .toList(),
    );
  }
}
