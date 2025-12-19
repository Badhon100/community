import 'package:equatable/equatable.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load communities
class LoadCommunities extends CommunityEvent {
  final int page;
  final int limit;
  final String? search;
  final bool isRefresh;

  const LoadCommunities({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [page, limit, search, isRefresh];
}
