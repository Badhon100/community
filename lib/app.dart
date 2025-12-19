import 'package:community/di/injection.dart';
import 'package:community/features/bottom_nav_bar/presentation/pages/bottom_nav_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community/core/bloc/bloc_providers.dart';
import 'package:community/core/theme/app_theme.dart';
import 'package:community/core/theme/theme_cubit.dart';
import 'package:community/features/authenticaction/presentation/pages/login_page.dart';
import 'core/storage/secure_storage_service.dart';
import 'core/storage/storage_keys.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialPage() async {
    final storage = sl<SecureStorageService>();
    final token = await storage.getString(StorageKey.token);

    if (token != null && token.isNotEmpty) {
      return const BottomNavBarPage(); // token exists → go to home
    } else {
      return const LoginPage(); // no token → go to login
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.getProviders(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return FutureBuilder<Widget>(
            future: _getInitialPage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MaterialApp(
                  home: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              return MaterialApp(
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                home: snapshot.data,
              );
            },
          );
        },
      ),
    );
  }
}
