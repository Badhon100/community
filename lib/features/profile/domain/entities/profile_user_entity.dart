import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int id;
  final String fullName;
  final String? firstName;
  final String? lastName;
  final String? profilePic;
  final String? coverPic;
  final String? bio;
  final String email;
  final String userType;
  final String status;
  final String isVerified;
  final DateTime createdAt;
  final DateTime lastLogin;
  final int totalCourses;
  final int totalCommunities;
  final int totalGroups;
  final int totalBundles;
  final int totalUnseenNotifications;
  final int totalUnseenPrivateChatMessages;
  final int totalUnseenGroupChatMessages;
  final String? globeLink;
  final String? youtubeLink;
  final String? linkedinLink;
  final String? facebookLink;

  // Optional: nested entities
  final SchoolOrderEntity? schoolOrder;
  final SchoolEntity? school;
  final AddonsEntity? addons;

  const ProfileEntity({
    required this.id,
    required this.fullName,
    this.firstName,
    this.lastName,
    this.profilePic,
    this.coverPic,
    this.bio,
    required this.email,
    required this.userType,
    required this.status,
    required this.isVerified,
    required this.createdAt,
    required this.lastLogin,
    required this.totalCourses,
    required this.totalCommunities,
    required this.totalGroups,
    required this.totalBundles,
    required this.totalUnseenNotifications,
    required this.totalUnseenPrivateChatMessages,
    required this.totalUnseenGroupChatMessages,
    this.globeLink,
    this.youtubeLink,
    this.linkedinLink,
    this.facebookLink,
    this.schoolOrder,
    this.school,
    this.addons,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    firstName,
    lastName,
    profilePic,
    coverPic,
    bio,
    email,
    userType,
    status,
    isVerified,
    createdAt,
    lastLogin,
    totalCourses,
    totalCommunities,
    totalGroups,
    totalBundles,
    totalUnseenNotifications,
    totalUnseenPrivateChatMessages,
    totalUnseenGroupChatMessages,
    globeLink,
    youtubeLink,
    linkedinLink,
    facebookLink,
    schoolOrder,
    school,
    addons,
  ];
}

class SchoolOrderEntity extends Equatable {
  final int id;
  final String plan;
  final String interval;

  const SchoolOrderEntity({
    required this.id,
    required this.plan,
    required this.interval,
  });

  @override
  List<Object?> get props => [id, plan, interval];
}

class SchoolEntity extends Equatable {
  final int id;
  final bool isPrivateChatEnabled;

  const SchoolEntity({required this.id, required this.isPrivateChatEnabled});

  @override
  List<Object?> get props => [id, isPrivateChatEnabled];
}

class AddonsEntity extends Equatable {
  final bool privetChat;
  final bool studentChat;
  final bool socialNetwork;
  final bool videoAnalytics;

  const AddonsEntity({
    required this.privetChat,
    required this.studentChat,
    required this.socialNetwork,
    required this.videoAnalytics,
  });

  @override
  List<Object?> get props => [
    privetChat,
    studentChat,
    socialNetwork,
    videoAnalytics,
  ];
}
