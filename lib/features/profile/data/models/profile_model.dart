
import 'package:community/features/profile/domain/entities/profile_user_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.fullName,
    super.firstName,
    super.lastName,
    super.profilePic,
    super.coverPic,
    super.bio,
    required super.email,
    required super.userType,
    required super.status,
    required super.isVerified,
    required super.createdAt,
    required super.lastLogin,
    required super.totalCourses,
    required super.totalCommunities,
    required super.totalGroups,
    required super.totalBundles,
    required super.totalUnseenNotifications,
    required super.totalUnseenPrivateChatMessages,
    required super.totalUnseenGroupChatMessages,
    super.globeLink,
    super.youtubeLink,
    super.linkedinLink,
    super.facebookLink,
    super.schoolOrder,
    super.school,
    super.addons,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      fullName: json['full_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePic: json['profile_pic'],
      coverPic: json['cover_pic'],
      bio: json['about_me'],
      email: json['email'],
      userType: json['user_type'],
      status: json['status'],
      isVerified: json['is_verified'],
      createdAt: DateTime.parse(json['created_at']),
      lastLogin: DateTime.parse(json['last_login']),
      totalCourses: json['total_courses'] ?? 0,
      totalCommunities: json['total_communities'] ?? 0,
      totalGroups: json['total_groups'] ?? 0,
      totalBundles: json['total_bundles'] ?? 0,
      totalUnseenNotifications: json['total_unseen_notifications'] ?? 0,
      totalUnseenPrivateChatMessages:
          json['total_unseen_private_chat_messages'] ?? 0,
      totalUnseenGroupChatMessages:
          json['total_unseen_group_chat_messages'] ?? 0,
      globeLink: json['globe_link'],
      youtubeLink: json['youtube_link'],
      linkedinLink: json['linkedin_link'],
      facebookLink: json['facebook_link'],
      schoolOrder: json['school_order'] != null
          ? SchoolOrderEntity(
              id: json['school_order']['id'],
              plan: json['school_order']['plan'],
              interval: json['school_order']['interval'],
            )
          : null,
      school: json['school'] != null
          ? SchoolEntity(
              id: json['school']['id'],
              isPrivateChatEnabled:
                  json['school']['is_private_chat_enabled'] == 1,
            )
          : null,
      addons: json['addons'] != null
          ? AddonsEntity(
              privetChat: json['addons']['privetChat'] ?? false,
              studentChat: json['addons']['studentChat'] ?? false,
              socialNetwork: json['addons']['socialNetwork'] ?? false,
              videoAnalytics: json['addons']['videoAnalytics'] ?? false,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'first_name': firstName,
      'last_name': lastName,
      'profile_pic': profilePic,
      'cover_pic': coverPic,
      'about_me': bio,
      'email': email,
      'user_type': userType,
      'status': status,
      'is_verified': isVerified,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin.toIso8601String(),
      'total_courses': totalCourses,
      'total_communities': totalCommunities,
      'total_groups': totalGroups,
      'total_bundles': totalBundles,
      'total_unseen_notifications': totalUnseenNotifications,
      'total_unseen_private_chat_messages': totalUnseenPrivateChatMessages,
      'total_unseen_group_chat_messages': totalUnseenGroupChatMessages,
      'globe_link': globeLink,
      'youtube_link': youtubeLink,
      'linkedin_link': linkedinLink,
      'facebook_link': facebookLink,
      'school_order': schoolOrder != null
          ? {
              'id': schoolOrder!.id,
              'plan': schoolOrder!.plan,
              'interval': schoolOrder!.interval,
            }
          : null,
      'school': school != null
          ? {
              'id': school!.id,
              'is_private_chat_enabled': school!.isPrivateChatEnabled ? 1 : 0,
            }
          : null,
      'addons': addons != null
          ? {
              'privetChat': addons!.privetChat,
              'studentChat': addons!.studentChat,
              'socialNetwork': addons!.socialNetwork,
              'videoAnalytics': addons!.videoAnalytics,
            }
          : null,
    };
  }
}
