
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/community_entity.dart';
import '../../domain/repositories/community_repository.dart';
import 'community_event.dart';
import 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityRepository repository;

  CommunityBloc({required this.repository}) : super(CommunityInitial()) {
    on<LoadCommunities>(_onLoadCommunities);
  }

  Future<void> _onLoadCommunities(
    LoadCommunities event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      // If refreshing, show loading
      if (event.isRefresh) {
        emit(CommunityLoading());
      }

      // Get current list if already loaded
      final currentList = state is CommunityLoaded && !event.isRefresh
          ? (state as CommunityLoaded).communities
          : <CommunityEntity>[];

      // Fetch from repository
      final result = await repository.getCommunities(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );

      result.fold(
        (failure) {
          emit(CommunityError(failure.message));
        },
        (fetchedList) {
          // Combine old + new list for pagination
          final allCommunities = event.isRefresh
              ? fetchedList
              : [...currentList, ...fetchedList];

          // Check if last page
          final hasReachedMax = fetchedList.length < event.limit;

          emit(
            CommunityLoaded(
              communities: allCommunities,
              hasReachedMax: hasReachedMax,
            ),
          );
        },
      );
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
}
