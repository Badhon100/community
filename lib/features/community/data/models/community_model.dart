import '../../domain/entities/community_entity.dart';

class CommunityModel extends CommunityEntity {
  const CommunityModel({
    required int id,
    required String title,
    String? thumbnail,
    required int totalMembers,
    required int totalFeeds,
    required String status,
  }) : super(
         id: id,
         title: title,
         thumbnail: thumbnail,
         totalMembers: totalMembers,
         totalFeeds: totalFeeds,
         status: status,
       );

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'] ?? json['thumbnail2'],
      totalMembers: json['total_members'],
      totalFeeds: json['total_feeds'],
      status: json['status'],
    );
  }
}
