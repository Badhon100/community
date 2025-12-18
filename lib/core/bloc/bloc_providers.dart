import 'package:community/core/theme/theme_cubit.dart';
import 'package:community/features/authenticaction/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';

class AppBlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
      BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
    ];
  }
}
