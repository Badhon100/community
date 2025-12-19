import 'package:equatable/equatable.dart';
import '../../domain/entities/community_entity.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object?> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<CommunityEntity> communities;
  final bool hasReachedMax;

  const CommunityLoaded({
    required this.communities,
    required this.hasReachedMax,
  });

  CommunityLoaded copyWith({
    List<CommunityEntity>? communities,
    bool? hasReachedMax,
  }) {
    return CommunityLoaded(
      communities: communities ?? this.communities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [communities, hasReachedMax];
}

class CommunityError extends CommunityState {
  final String message;

  const CommunityError(this.message);

  @override
  List<Object?> get props => [message];
}
