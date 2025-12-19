import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc/bloc_providers.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/storage/secure_storage_service.dart';
import 'core/storage/storage_keys.dart';
import 'features/authenticaction/presentation/pages/login_page.dart';
import 'features/bottom_nav_bar/presentation/pages/bottom_nav_bar_page.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetIt.I<SecureStorageService>();

    return MultiBlocProvider(
      providers: AppBlocProviders.getProviders(),
      child: MaterialAppBuilder(storage: storage),
    );
  }
}

class MaterialAppBuilder extends StatelessWidget {
  final SecureStorageService storage;
  const MaterialAppBuilder({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: AuthChecker(storage: storage),
    );
  }
}

class AuthChecker extends StatefulWidget {
  final SecureStorageService storage;
  const AuthChecker({super.key, required this.storage});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final t = await widget.storage.getString(StorageKey.token);
    setState(() {
      token = t;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (token != null && token!.isNotEmpty) {
      return const BottomNavBarPage();
    } else {
      return const LoginPage();
    }
  }
}
