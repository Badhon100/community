import 'package:community/core/helpers/dialog_helper.dart';
import 'package:community/core/theme/app_colors.dart';
import 'package:community/core/theme/theme_cubit.dart';
import 'package:community/core/widgets/custom_widgets.dart';
import 'package:community/features/authenticaction/presentation/pages/login_page.dart';
import 'package:community/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadProfile());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (_) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  child: CupertinoSwitch(
                    trackColor: AppColors.lightText,
                    value: isDark,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ),
                const Icon(Icons.dark_mode),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLogoutLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final profile = state.profile;

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileBloc>().add(LoadProfile());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Cover Photo
                      if (profile.coverPic != null)
                        SizedBox(
                          height: 180,
                          child: Image.network(
                            profile.coverPic!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 12),
                      // Profile Pic + Full Name + Verified Badge
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: profile.profilePic != null
                                  ? NetworkImage(profile.profilePic!)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        profile.fullName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      if (profile.isVerified == 'VERIFIED')
                                        Icon(
                                          Icons.verified,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                  if (profile.bio != null)
                                    Text(
                                      profile.bio!,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: [
                            _infoCard(
                              'Courses',
                              profile.totalCourses.toString(),
                            ),
                            _infoCard(
                              'Communities',
                              profile.totalCommunities.toString(),
                            ),
                            _infoCard('Groups', profile.totalGroups.toString()),
                            _infoCard(
                              'Bundles',
                              profile.totalBundles.toString(),
                            ),
                            _infoCard(
                              'Notifications',
                              profile.totalUnseenNotifications.toString(),
                            ),
                            _infoCard(
                              'Private Messages',
                              profile.totalUnseenPrivateChatMessages.toString(),
                            ),
                            _infoCard(
                              'Group Messages',
                              profile.totalUnseenGroupChatMessages.toString(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textRow('Email', profile.email),
                            _textRow('User Type', profile.userType),
                            _textRow('Account Status', profile.status),
                            _textRow(
                              'Member Since',
                              'Member since ${DateFormat('MMM yyyy').format(profile.createdAt)}',
                            ),

                            _textRow(
                              'Last Login',
                              timeago.format(profile.lastLogin),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Social / Links
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Links',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            if (profile.globeLink != null)
                              _linkRow('Website', profile.globeLink!),
                            if (profile.youtubeLink != null)
                              _linkRow('YouTube', profile.youtubeLink!),
                            if (profile.linkedinLink != null)
                              _linkRow('LinkedIn', profile.linkedinLink!),
                            if (profile.facebookLink != null)
                              _linkRow('Facebook', profile.facebookLink!),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Logout Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButton(
                          text: 'Logout',
                          backgroundColor: AppColors.error,
                          onPressed: () {
                            showAppConfirmationDialog(
                              context: context,
                              title: 'Logout',
                              message: 'Are you sure you want to logout?',
                              confirmText: 'Logout',
                              cancelText: 'Cancel',
                              isDestructive: true,
                              onConfirm: () {
                                // Call logout endpoint
                                context.read<ProfileBloc>().add(
                                  LogoutProfileRequested(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.failure.toString()));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _textRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _linkRow(String title, String url) {
    return GestureDetector(
      onTap: () async {
        try {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } catch (e) {
          print('Could not launch $e');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('$title: $url', style: const TextStyle(color: Colors.blue)),
      ),
    );
  }
}
