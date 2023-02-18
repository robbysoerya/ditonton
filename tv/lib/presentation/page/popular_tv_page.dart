import 'package:core/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/bloc.dart';

class PopularTVPage extends StatefulWidget {
  const PopularTVPage({super.key});

  @override
  State<PopularTVPage> createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTVBloc>().add(PopularTVStarted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVBloc, PopularTVState>(
          builder: (context, state) {
            if (state is PopularTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TVCard(tv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is PopularTVError) {
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
