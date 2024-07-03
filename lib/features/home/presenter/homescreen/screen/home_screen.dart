import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_in_play_proof/features/home/domain/entity/anime.dart';
import 'package:just_in_play_proof/features/home/domain/providers/home_providers.dart';
import 'package:just_in_play_proof/widgets/drawe/just_play_drawe.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LayoutHome(),
      drawer: JustPlayDrawer(),
    );
  }
}

class LayoutHome extends StatelessWidget {
  const LayoutHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
        ),
        AnimeList()
      ],
    );
  }
}

class AnimeList extends ConsumerWidget {
  const AnimeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularAnimeCount = ref.watch(popularAnimeCountProvider);

    return popularAnimeCount.when(
      data: (count) {
        return SliverList.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            final AsyncValue<Anime> currentPopularAnimeFromIndex = ref
                .watch(paginatedPopularAnimeProvider(index ~/ 19))
                .whenData((pageData) {
              return pageData.list[index % 19];
            });

            return ProviderScope(
              overrides: [
                currentPopularAnimeProvider
                    .overrideWithValue(currentPopularAnimeFromIndex)
              ],
              child: const PopularPersonListItem(),
            );
          },
        );
      },
      error: (e, s) => const SliverToBoxAdapter(
        child: CircularProgressIndicator(),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class PopularPersonListItem extends ConsumerWidget {
  const PopularPersonListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Anime> personAsync =
        ref.watch(currentPopularAnimeProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          child: personAsync.when(
            data: (Anime anime) => SizedBox(
              height: 150,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 150,
                          child: Shimmer.fromColors(
                            baseColor: Colors.transparent,
                            highlightColor: Colors.white,
                            child: Container(
                              height: 140,
                              width: 150,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FadeInImage.assetNetwork(
                          height: 120,
                          width: 150,
                          placeholder: '',
                          fit: BoxFit.fitHeight,
                          placeholderErrorBuilder:
                              (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                          imageSemanticLabel: '',
                          imageErrorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                          image:
                              'https://wsrv.nl/?url=https://simkl.in/posters/${anime.poster}_w.jpg',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            anime.title,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            anime.year,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ), // List item content
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
