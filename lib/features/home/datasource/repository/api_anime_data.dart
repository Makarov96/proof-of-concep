import 'package:dio/dio.dart';
import 'package:just_in_play_proof/core/common/env/env_conf.dart';
import 'package:just_in_play_proof/core/core_config/network/just_network_options.dart';
import 'package:just_in_play_proof/core/error/error.dart';
import 'package:just_in_play_proof/features/home/datasource/model/anime_model.dart';
import 'package:just_in_play_proof/features/home/domain/entity/anime_response.dart';
import 'package:just_in_play_proof/features/home/domain/repository/anime_repository.dart';

class ApiAnimeData extends AnimeRepository {
  final JustNetwork _justNetwork;

  ApiAnimeData({required JustNetwork justNetwork}) : _justNetwork = justNetwork;
  @override
  Future<(JustInPLayException?, AnimeResponse)> getAnime({
    int page = 1,
  }) async {
    try {
      final response = await _justNetwork.get(
          '/anime/genres/all/all-types/all-countries/tvtokyo/all-years/popular-today?&page=$page&limit=20&client_id=${EnvConf.simklApiKey}');

      final anime = List.from(response.data)
          .map((item) => AnimeModel.fromMap(item))
          .toList();

      final counter =
          int.parse(response.headers.map['x-pagination-page']?.first ?? '0');

      var animeResponse = AnimeResponse(
        list: anime,
        totalCounter: 217,
        pageIndex: counter,
      );
      return (null, animeResponse);
    } on DioException catch (e) {
      return (
        ServerError(
            message: e.response?.data['message'],
            preffix: e.hashCode.toString()),
        const AnimeResponse.mock()
      );
    }
  }
}
