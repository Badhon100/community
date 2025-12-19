import 'package:community/features/bottom_nav_bar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:community/features/bottom_nav_bar/presentation/widges/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({super.key});

  static final List<Widget> _pages = [
    const Center(child: Text('Home')),
    const Center(child: Text('community')),
    const Center(child: Text('schools')),
    const Center(child: Text('files')),
    const Center(child: Text('Profile page')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBarBloc(),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return Scaffold(
            extendBody: true,
            backgroundColor: theme.scaffoldBackgroundColor, // dynamic
            body: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
              builder: (context, state) {
                return _pages[state.currentIndex];
              },
            ),
            bottomNavigationBar: const GlassBottomNavBar(),
          );
        },
      ),
    );
  }
}
