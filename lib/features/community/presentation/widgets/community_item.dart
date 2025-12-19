import 'package:community/features/community/domain/entities/community_entity.dart';
import 'package:community/features/community/presentation/widgets/badge.dart';
import 'package:flutter/material.dart';

class CommunityItem extends StatelessWidget {
  final CommunityEntity community;
  final VoidCallback onTap;

  const CommunityItem({super.key, required this.community, required this.onTap});

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
                          Badged(
                            text: '${community.totalMembers} members',
                            color: Colors.blue.shade100,
                            textColor: Colors.blue.shade800,
                          ),
                          const SizedBox(width: 4),
                          Badged(
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
