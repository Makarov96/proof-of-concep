import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  final String title;
  final String year;
  final String poster;
  final String animeType;
  final num rank;
  const Anime({
    required this.title,
    required this.year,
    required this.poster,
    required this.animeType,
    required this.rank,
  });

  const Anime.mock()
      : title = '',
        animeType = '',
        year = '',
        poster = '',
        rank = 0;

  @override
  List<Object> get props {
    return [
      title,
      year,
      poster,
      animeType,
      rank,
    ];
  }

  @override
  String toString() {
    return 'Anime(title: $title, year: $year, poster: $poster, animeType: $animeType, rank: $rank)';
  }
}
