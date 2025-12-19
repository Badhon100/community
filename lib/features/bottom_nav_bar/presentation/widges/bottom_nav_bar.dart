import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_nav_bar_bloc.dart';

class GlassBottomNavBar extends StatelessWidget {
  const GlassBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    // Make bar semi-transparent but visible in both modes
                    color: theme.brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavItem(
                        icon: Icons.home_filled,
                        index: 0,
                        currentIndex: state.currentIndex,
                      ),
                      _NavItem(
                        icon: Icons.group,
                        index: 1,
                        currentIndex: state.currentIndex,
                      ),
                      _NavItem(
                        icon: Icons.school,
                        index: 2,
                        currentIndex: state.currentIndex,
                      ),
                      _NavItem(
                        icon: Icons.file_copy,
                        index: 3,
                        currentIndex: state.currentIndex,
                      ),
                      _NavItem(
                        icon: Icons.person,
                        index: 4,
                        currentIndex: state.currentIndex,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        context.read<BottomNavBarBloc>().add(BottomNavIndexChanged(index));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.brightness == Brightness.dark
              ? Colors.white70
              : Colors.black54,
        ),
      ),
    );
  }
}
