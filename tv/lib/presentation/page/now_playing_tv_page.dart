import 'package:core/presentation/widgets/tv_card.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/now_playing_tv_notifier.dart';

class NowPlayingTVPage extends StatefulWidget {

  const NowPlayingTVPage({super.key});

  @override
  _NowPlayingTVPageState createState() => _NowPlayingTVPageState();
}

class _NowPlayingTVPageState extends State<NowPlayingTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingTVNotifier>(context, listen: false)
            .fetchOnTheAirTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TVCard(tv);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
