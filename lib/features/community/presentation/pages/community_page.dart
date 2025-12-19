import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/community_entity.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search Communities',
            border: InputBorder.none,
          ),
          onSubmitted: (_) {
            _loadCommunities(isRefresh: true);
          },
        ),
      ),
      body: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          if (state is CommunityLoading && _page == 1) {
            // Initial loading
            return const Center(child: CircularProgressIndicator());
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
                  return _CommunityItem(community: community, onTap: () {
                    
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

class _CommunityItem extends StatelessWidget {
  final CommunityEntity community;
  final VoidCallback onTap;

  const _CommunityItem({required this.community, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: community.thumbnail != null
                      ? Image.network(
                          community.thumbnail!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(height: 100, color: Colors.grey.shade300),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title (2 lines max)
                      SizedBox(
                        height: 40, // approx height for 2 lines
                        child: Text(
                          community.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _Badge(
                            text: '${community.totalMembers} members',
                            color: Colors.blue.shade100,
                            textColor: Colors.blue.shade800,
                          ),
                          const SizedBox(width: 4),
                          _Badge(
                            text: '${community.totalFeeds} posts',
                            color: Colors.green.shade100,
                            textColor: Colors.green.shade800,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (community.status == 'EXPIRED')
            Positioned(
              top: 10,
              right: 0,
              child: Transform.rotate(
                angle: 0.5, // radians for slight diagonal
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: const Text(
                    'EXPIRED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const _Badge({
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}
