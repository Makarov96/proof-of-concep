import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/features/home/domain/entity/anime_response.dart';

abstract class AnimeRepository {
  Future<(JustInPLayException?, AnimeResponse)> getAnime({
    int page = 1,
  });
}
