import 'package:core/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/bloc.dart';

class TopRatedTVPage extends StatefulWidget {
  const TopRatedTVPage({super.key});

  @override
  State<TopRatedTVPage> createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTVBloc>().add(TopRatedTVStarted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
          builder: (context, state) {
            if (state is TopRatedTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TVCard(tv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is TopRatedTVError) {
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
