import 'package:core/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/bloc.dart';

class NowPlayingTVPage extends StatefulWidget {
  const NowPlayingTVPage({super.key});

  @override
  State<NowPlayingTVPage> createState() => _NowPlayingTVPageState();
}

class _NowPlayingTVPageState extends State<NowPlayingTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NowPlayingTVBloc>().add(NowPlayingTVStarted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTVBloc, NowPlayingTVState>(
          builder: (context, state) {
            if (state is NowPlayingTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTVSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TVCard(tv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is NowPlayingTVError) {
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
}
