import 'package:community/features/bottom_nav_bar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:community/features/bottom_nav_bar/presentation/widges/bottom_nav_bar.dart';
import 'package:community/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  final List<Widget> _pages = const [
    Center(child: Text('Home')),
    Center(child: Text('Community')),
    Center(child: Text('Schools')),
    Center(child: Text('Files')),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => BottomNavBarBloc(),
      child: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            body: IndexedStack(index: state.currentIndex, children: _pages),
            bottomNavigationBar: const GlassBottomNavBar(),
          );
        },
      ),
    );
  }
}
