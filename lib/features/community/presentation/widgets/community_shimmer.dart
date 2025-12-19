import 'package:community/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommunityShimmerItem extends StatelessWidget {
  const CommunityShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.brightness == Brightness.dark
              ? AppColors.lightBackground.withValues(alpha: 0.5)
              : AppColors.lightText.withValues(alpha: 0.5),
      highlightColor: theme.brightness == Brightness.dark
              ? AppColors.lightBackground.withValues(alpha: 0.5)
              : AppColors.lightText.withValues(alpha: 0.5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail placeholder
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
              ? AppColors.lightBackground.withValues(alpha: 0.5)
              : AppColors.lightText.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: theme.brightness == Brightness.dark
              ? AppColors.lightBackground.withValues(alpha: 0.5)
              : AppColors.lightText.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(height: 12, width: 60, color: theme.brightness == Brightness.dark
              ? AppColors.lightBackground.withValues(alpha: 0.5)
              : AppColors.lightText.withValues(alpha: 0.5)),
                      const SizedBox(width: 4),
                      Container(height: 12, width: 40, color: theme.brightness == Brightness.dark
              ? AppColors.lightBackground.withValues(alpha: 0.5)
              : AppColors.lightText.withValues(alpha: 0.5)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
