import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_season_detail_bloc.dart';

class TVSeasonDetailArgs {
  final int id;
  final int season;

  const TVSeasonDetailArgs({required this.id, required this.season});
}

class TVSeasonDetailPage extends StatefulWidget {
  final TVSeasonDetailArgs args;
  const TVSeasonDetailPage({required this.args, Key? key}) : super(key: key);

  @override
  State<TVSeasonDetailPage> createState() => _TVSeasonDetailPageState();
}

class _TVSeasonDetailPageState extends State<TVSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeasonDetailBloc>().add(TvSeasonDetailStarted(
          id: widget.args.id, season: widget.args.season)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Season Detail'),
      ),
      body: BlocBuilder<TvSeasonDetailBloc, TvSeasonDetailState>(
          builder: (context, state) {
        if (state is TvSeasonDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeasonDetailSuccess) {
          return ContentWidget(tvSeasons: state.seasonsDetail);
        } else if (state is TvSeasonDetailError) {
          return Text(state.message);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final TVSeasonsDetail tvSeasons;
  const ContentWidget({required this.tvSeasons, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeasons.posterPath}',
            height: 200,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(
            tvSeasons.name,
            style: kHeading6,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Episodes',
            style: kHeading6,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tvSeasons.episodes.length,
              itemBuilder: (context, index) {
                final episode = tvSeasons.episodes[index];
                return ListTile(
                  leading: Text(
                    'Episode ${episode.episodeNumber}',
                    style: kSubtitle,
                  ),
                  title: Text(
                    episode.name,
                    style: kSubtitle,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
