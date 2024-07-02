import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapgallery/core/base_state.dart';
import 'package:snapgallery/core/util.dart';
import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/domain/entity/user/user.dart';
import 'package:snapgallery/injection_container.dart';
import 'package:snapgallery/presentation/bloc/user_collection_bloc.dart';
import 'package:snapgallery/presentation/cubit/user_profile_cubit.dart';
import 'package:snapgallery/presentation/pages/user_detail_page.dart';
import 'package:snapgallery/presentation/widgets/collection_preview.dart';

///
/// This is the user profile page that shows the user's profile image, name, and collections and likes.
///
class MenuUserProfile extends StatelessWidget {
  const MenuUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DI<UserProfileCubit>(param1: 'me'),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(child:
                BlocBuilder<UserProfileCubit, DataState<User>>(
                    builder: (context, state) {
              if (state.status == DataStatus.loading ||
                  state.status == DataStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == DataStatus.error) {
                return Center(child: Text(state.errorMessage!));
              } else {
                User user = state.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info section
                    UserInfoSection(
                        profileImageUrl: user.profileImage.medium,
                        name: user.name,
                        onBackPress: () {
                          DI<ZoomDrawerController>().close?.call();
                        },
                        onEditProfilePress: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => UserDetailPage(
                                      userName: user.username,
                                    )),
                          );
                        }),
                    // User stats
                    Titles(
                        totalCollections: user.totalCollections,
                        totalLikes: user.totalLikes),
                    // Photo grid
                    BlocProvider<CollectionsBloc>(
                        create: (_) =>
                            DI<CollectionsBloc>(param1: user.username),
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 10.0),
                            child: BlocBuilder<CollectionsBloc,
                                    ListState<Collection>>(
                                builder: (context, state) {
                              List<String> urls = [];
                              String firstCollectionName = '';
                              int firstCollectionNum = 0;
                              if (state.data.isNotEmpty) {
                                firstCollectionName = state.data.first.title;
                                firstCollectionNum =
                                    state.data.first.totalPhotos;
                              }
                              if (state.data.isNotEmpty &&
                                  state.data.first.previewPhotos != null) {
                                urls = state.data.first.previewPhotos!
                                    .map((photo) {
                                  return photo.urls.small;
                                }).toList();
                              }
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 270,
                                      height: 220,
                                      child: CollectionPreview(images: urls),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(firstCollectionName,
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      "$firstCollectionNum images •  Curated by ${user.name}",
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  ]);
                            }))),
                    // Menu items
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60, // Set the width of the divider
                            child: const Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('My Photos',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 8),
                          Text('Hiring',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 8),
                          Text('History',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 8),
                          Text('License',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              }
            })),
          ),
        ));
  }
}

class Titles extends StatelessWidget {
  final int totalCollections;
  final int totalLikes;

  const Titles(
      {super.key, required this.totalCollections, required this.totalLikes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          TextButton.icon(
              style: ButtonStyle(
                  iconColor: WidgetStateProperty.all(Colors.black),
                  splashFactory:
                      NoSplash.splashFactory, // Disable splash effect
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                // Navigator.pushNamed(context, '/collections');
              },
              icon: const Icon(CupertinoIcons.collections_solid),
              label: Text(
                'Collections ${formatNumber(totalCollections)}',
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              )),
          //const Icon(CupertinoIcons.),
          //Text('Collections ${user.totalCollections}'),
          const SizedBox(width: 2),
          TextButton.icon(
              onPressed: () {
                // Navigator.pushNamed(context, '/likes');
              },
              style: ButtonStyle(
                  iconColor: WidgetStateProperty.all(Colors.grey),
                  splashFactory:
                      NoSplash.splashFactory, // Disable splash effect
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              icon: const Icon(CupertinoIcons.heart),
              label: Text(
                'Likes ${formatNumber(totalLikes)}',
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              )),
        ],
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final VoidCallback onBackPress;
  final VoidCallback onEditProfilePress;

  const UserInfoSection(
      {super.key,
      required this.profileImageUrl,
      required this.name,
      required this.onBackPress,
      required this.onEditProfilePress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 40.0, left: 20.0, right: 16.0, bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 50, backgroundImage: NetworkImage(profileImageUrl)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  name,
                  style: GoogleFonts.roboto(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {
                    onEditProfilePress();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  child: Text('Edit Profile',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          IconButton(
            icon: const Icon(
              CupertinoIcons.square_arrow_right_fill,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {
              onBackPress();
            },
          ),
        ],
      ),
    );
  }
}
