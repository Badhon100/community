import 'package:equatable/equatable.dart';

class CommunityEntity extends Equatable {
  final int id;
  final String title;
  final String? thumbnail;
  final int totalMembers;
  final int totalFeeds;
  final String status;

  const CommunityEntity({
    required this.id,
    required this.title,
    this.thumbnail,
    required this.totalMembers,
    required this.totalFeeds,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    thumbnail,
    totalMembers,
    totalFeeds,
    status,
  ];
}
