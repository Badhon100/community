import 'package:community/core/theme/theme_cubit.dart';
import 'package:community/features/authenticaction/presentation/bloc/auth/auth_bloc.dart';
import 'package:community/features/bottom_nav_bar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:community/features/community/presentation/bloc/community_bloc.dart';
import 'package:community/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';

class AppBlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
      BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
      BlocProvider<BottomNavBarBloc>(create: (_) => sl<BottomNavBarBloc>()),
      BlocProvider<ProfileBloc>(create: (_) => sl<ProfileBloc>()),
      BlocProvider<CommunityBloc>(create: (_) => sl<CommunityBloc>()),
    ];
  }
}
