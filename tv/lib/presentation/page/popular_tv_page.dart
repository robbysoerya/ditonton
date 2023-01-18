import 'package:core/presentation/widgets/tv_card.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/popular_tv_notifier.dart';

class PopularTVPage extends StatefulWidget {

  const PopularTVPage({super.key});

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTVNotifier>(context, listen: false)
            .fetchPopularTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTVNotifier>(
          builder: (context, data, child) {
            if (data.popularTVState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.popularTVState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.popularTV[index];
                  return TVCard(tv);
                },
                itemCount: data.popularTV.length,
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
