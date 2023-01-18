import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;
  const CustomDrawer({required this.content, Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Ditonton'),
          accountEmail: Text('robbysoerya6@gmail.com'),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png',
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () => _animationController.reverse(),
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('TV Series'),
          onTap: () {
            _animationController.reverse();
            Navigator.pushNamed(context, TV_ROUTE);
          }
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist Movie'),
          onTap: () {
            _animationController.reverse();
            Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist TV'),
          onTap: () {
            _animationController.reverse();
            Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
          },
        )
      ],
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: toggle,
            child: const Icon(Icons.menu),
        ),
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = MediaQuery.of(context).size.width * 0.5 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: widget.content,
              ),
            ],
          );
        }
      ),
    );
  }
}
