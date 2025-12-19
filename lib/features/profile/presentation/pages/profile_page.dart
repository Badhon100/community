import 'package:community/core/theme/app_colors.dart';
import 'package:community/core/theme/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Row(
            children: [
              SizedBox(
                height: 30,
                child: CupertinoSwitch(
                  trackColor: AppColors.lightText,
                  value: isDark,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ),
              const Icon(Icons.dark_mode),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
