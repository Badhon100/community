import 'package:community/core/theme/app_colors.dart';
import 'package:community/features/community/presentation/widgets/community_item.dart';
import 'package:community/features/community/presentation/widgets/community_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/community_bloc.dart';
import '../bloc/community_event.dart';
import '../bloc/community_state.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  int _page = 1;
  final int _limit = 20;
  bool _isFetchingNextPage = false;

  @override
  void initState() {
    super.initState();
    _loadCommunities();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<CommunityBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingNextPage &&
        state is CommunityLoaded &&
        !state.hasReachedMax) {
      _isFetchingNextPage = true;
      _page += 1;

      bloc.add(
        LoadCommunities(
          page: _page,
          limit: _limit,
          search: _searchController.text.trim(),
        ),
      );
    }
  }

  void _loadCommunities({bool isRefresh = false}) {
    if (isRefresh) _page = 1;
    context.read<CommunityBloc>().add(
      LoadCommunities(
        page: _page,
        limit: _limit,
        search: _searchController.text.trim(),
        isRefresh: isRefresh,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: theme.brightness == Brightness.light
                  ? AppColors.lightBackground.withValues(alpha: 0.5)
                  : AppColors.lightText
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            fillColor: theme.brightness == Brightness.dark
                ? AppColors.lightBackground.withValues(alpha: 0.5)
                : AppColors.lightText.withValues(alpha: 0.5),
          ),
          onSubmitted: (_) {
            _loadCommunities(isRefresh: true);
          },
        ),
      ),
      body: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          if (state is CommunityLoading && _page == 1) {
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(
                12,
                12,
                12,
                12 + MediaQuery.of(context).padding.bottom + 60,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: 6, // show 6 shimmer items
              itemBuilder: (context, index) => const CommunityShimmerItem(),
            );
          }

          if (state is CommunityError) {
            return Center(child: Text(state.message));
          }

          if (state is CommunityLoaded) {
            if (state.communities.isEmpty) {
              return const Center(child: Text("No Communities Found"));
            }

            return RefreshIndicator(
              onRefresh: () async => _loadCommunities(isRefresh: true),
              child: GridView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(
                  12,
                  12,
                  12,
                  12 +
                      MediaQuery.of(context).padding.bottom +
                      12, // extra bottom space
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.hasReachedMax
                    ? state.communities.length
                    : state.communities.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.communities.length) {
                    // Pagination loading indicator
                    return const Center(child: CircularProgressIndicator());
                  }

                  final community = state.communities[index];
                  return CommunityItem(community: community, onTap: () {
                    
                  },);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
