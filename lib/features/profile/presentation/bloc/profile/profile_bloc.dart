import 'package:community/core/errors/failures.dart';
import 'package:community/features/profile/domain/entities/profile_user_entity.dart';
import 'package:community/features/profile/domain/usecases/logout_profile_usecase.dart';
import 'package:community/features/profile/domain/usecases/profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogoutProfileUseCase logoutProfileUseCase; // ✅ ADD

  ProfileBloc({
    required this.getProfileUseCase,
    required this.logoutProfileUseCase,
  }) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await getProfileUseCase();
      result.fold(
        (failure) => emit(ProfileError(failure)),
        (profile) => emit(ProfileLoaded(profile)),
      );
    });

    on<LogoutProfileRequested>((event, emit) async {
      emit(ProfileLogoutLoading());

      final result = await logoutProfileUseCase();
      result.fold(
        (failure) => emit(ProfileError(failure)),
        (_) => emit(ProfileLogoutSuccess()),
      );
    });
  }
}
