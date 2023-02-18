import 'package:core/presentation/widgets/tv_card.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/watch_list_tv_bloc.dart';

class WatchlistTVPage extends StatefulWidget {
  const WatchlistTVPage({super.key});

  @override
  State<WatchlistTVPage> createState() => _WatchlistTVPageState();
}

class _WatchlistTVPageState extends State<WatchlistTVPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchListTVBloc>().add(WatchListTVStarted()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchListTVBloc>().add(WatchListTVStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListTVBloc, WatchListTVState>(
          builder: (context, state) {
            if (state is WatchListTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListTVSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TVCard(tv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is WatchListTVError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
