import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/core/core_config/network/provider/network_provider.dart';
import 'package:just_in_play_proof/features/home/datasource/repository/api_anime_data.dart';
import 'package:just_in_play_proof/features/home/domain/entity/anime.dart';
import 'package:just_in_play_proof/features/home/domain/entity/anime_response.dart';
import 'package:just_in_play_proof/features/home/domain/repository/anime_repository.dart';

final animeRepositoryProvider = Provider<AnimeRepository>(
  (ref) => ApiAnimeData(justNetwork: ref.read(justNetworkProvider)),
);
var previusList = <Anime>[];
final paginatedPopularAnimeProvider = FutureProvider.family<AnimeResponse, int>(
  (ref, int pageIndex) async {
    final animeRepository = ref.watch(animeRepositoryProvider);
    var index = pageIndex + 1;

    final either = await animeRepository.getAnime(page: index);
    var (f, data) = either;

    if (f == null) {
      previusList.addAll(data.list);
      return data;
    } else {
      return AnimeResponse(
        list: previusList,
        totalCounter: 200,
        pageIndex: 11,
      );
    }
  },
);

final popularAnimeCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(paginatedPopularAnimeProvider(0)).whenData(
    (AnimeResponse pageData) {
      return pageData.totalCounter;
    },
  );
});

final currentPopularAnimeProvider = Provider<AsyncValue<Anime>>((ref) {
  throw UnimplementedError();
});
