part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileLogoutLoading extends ProfileState {}

class ProfileLogoutSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final Failure failure;
  ProfileError(this.failure);

  @override
  List<Object?> get props => [failure];
}
