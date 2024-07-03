import 'dart:convert';

import 'package:just_in_play_proof/features/home/domain/entity/anime.dart';

class AnimeModel extends Anime {
  const AnimeModel(
      {required super.title,
      required super.year,
      required super.poster,
      required super.animeType,
      required super.rank});
  Anime copyWith({
    String? title,
    String? year,
    String? poster,
    String? animeType,
    num? rank,
  }) {
    return Anime(
      title: title ?? this.title,
      year: year ?? this.year,
      poster: poster ?? this.poster,
      animeType: animeType ?? this.animeType,
      rank: rank ?? this.rank,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'year': year});
    result.addAll({'poster': poster});
    result.addAll({'animeType': animeType});
    result.addAll({'rank': rank});

    return result;
  }

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      title: map['title'] ?? '',
      year: map['year'].toString(),
      poster: map['poster'] ?? '',
      animeType: map['animeType'] ?? '',
      rank: map['rank'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeModel.fromJson(String source) =>
      AnimeModel.fromMap(json.decode(source));
}
