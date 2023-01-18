import 'package:core/presentation/widgets/tv_card.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/top_rated_tv_notifier.dart';

class TopRatedTVPage extends StatefulWidget {

  const TopRatedTVPage({super.key});

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTVNotifier>(context, listen: false)
            .fetchTopRatedTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTVNotifier>(
          builder: (context, data, child) {
            if (data.topRatedTVState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.topRatedTVState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.topRatedTV[index];
                  return TVCard(tv);
                },
                itemCount: data.topRatedTV.length,
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
