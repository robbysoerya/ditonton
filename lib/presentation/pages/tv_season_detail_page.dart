import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_seasons_detail.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVSeasonDetailArgs {
  final int id;
  final int season;

  const TVSeasonDetailArgs({required this.id, required this.season});
}

class TVSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = 'tv/season/detail';

  final TVSeasonDetailArgs args;
  const TVSeasonDetailPage({required this.args, Key? key}) : super(key: key);

  @override
  State<TVSeasonDetailPage> createState() => _TVSeasonDetailPageState();
}

class _TVSeasonDetailPageState extends State<TVSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TVSeasonDetailNotifier>(context, listen: false)
            .fetchTVSeasonDetail(widget.args.id, widget.args.season));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season Detail'),
      ),
      body:
          Consumer<TVSeasonDetailNotifier>(builder: (context, provider, child) {
        if (provider.state == RequestState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == RequestState.loaded) {
          return ContentWidget(tvSeasons: provider.tvSeasons);
        } else {
          return Text(provider.message);
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
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(
            tvSeasons.name,
            style: kHeading6,
          ),
          SizedBox(
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
