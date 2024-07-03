import 'package:equatable/equatable.dart';

import 'package:just_in_play_proof/features/home/domain/entity/anime.dart';

class AnimeResponse extends Equatable {
  const AnimeResponse(
      {required this.list,
      required this.totalCounter,
      required this.pageIndex});

  const AnimeResponse.mock()
      : list = const [],
        totalCounter = 0,
        pageIndex = 0;

  AnimeResponse copyWith({
    List<Anime>? list,
    int? totalCounter,
    int? pageIndex,
  }) {
    return AnimeResponse(
      list: list ?? this.list,
      totalCounter: totalCounter ?? this.totalCounter,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object> get props => [list, totalCounter];
  final List<Anime> list;
  final int totalCounter;
  final int pageIndex;
}
