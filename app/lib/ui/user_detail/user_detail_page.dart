import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../di/di.dart';
import '../../util.dart';
import '../menu/bloc/user_collection_bloc.dart';
import 'bloc/user_likes_bloc.dart';
import '../menu/cubit/user_profile_cubit.dart';
import '../../base/widget/image_title.dart';
import '../../base/widget/remote_image.dart';
import '../../base/widget/user_collection_list.dart';
import '../photo_detail/photo_detail_page.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key, required this.userName});

  final String userName;

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late EasyRefreshController _refreshController;

  void _onBack() {}

  void handleTap(Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoDetailPage(photo: photo)),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DI<UserProfileCubit>(param1: widget.userName),
        child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: BlocBuilder<UserProfileCubit, DataState<User>>(
                builder: (context, state) {
              if (state.status == DataStatus.loading ||
                  state.status == DataStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == DataStatus.error) {
                return const Center(child: Text('load error'));
              } else {
                return EasyRefresh.builder(
                    header: const ClassicHeader(
                      clamping: true,
                      position: IndicatorPosition.locator,
                      mainAxisAlignment: MainAxisAlignment.end,
                      dragText: 'Pull to refresh',
                      armedText: 'Release ready',
                      readyText: 'Refreshing...',
                      processingText: 'Refreshing...',
                      processedText: 'Succeeded',
                      noMoreText: 'No more',
                      failedText: 'Failed',
                      messageText: 'Last updated at %T',
                    ),
                    footer: const ClassicFooter(
                      position: IndicatorPosition.locator,
                      dragText: 'Pull to load',
                      armedText: 'Release ready',
                      readyText: 'Loading...',
                      processingText: 'Loading...',
                      processedText: 'Succeeded',
                      noMoreText: 'No more',
                      failedText: 'Failed',
                      messageText: 'Last updated at %T',
                    ),
                    controller: _refreshController,
                    onRefresh: () => {},
                    onLoad: () => {},
                    childBuilder: (context, physics) {
                      return ScrollConfiguration(
                          behavior: const ERScrollBehavior(),
                          child: ExtendedNestedScrollView(
                              physics: physics,
                              onlyOneScrollInBody: true,
                              pinnedHeaderSliverHeightBuilder: () {
                                return MediaQuery.of(context).padding.top +
                                    kToolbarHeight;
                              },
                              headerSliverBuilder:
                                  (context, innerBoxIsScrolled) {
                                return <Widget>[
                                  const HeaderLocator.sliver(
                                      clearExtent: false),
                                  SliverAppBar(
                                    centerTitle: true,
                                    surfaceTintColor:
                                        Color.fromARGB(164, 66, 65, 73),
                                    backgroundColor:
                                        Color.fromARGB(164, 66, 65, 73),
                                    foregroundColor: Colors.white,
                                    expandedHeight: 320.0,
                                    floating: false,
                                    pinned: true,
                                    title: SlideInTitle(
                                      child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              state.data!.profileImage.small)),
                                    ),
                                    flexibleSpace: FlexibleSpaceBar(
                                      background: Background(user: state.data!),
                                    ),
                                  ),
                                ];
                              },
                              body: Column(children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                    child: Container(
                                      color: Colors.grey
                                          .shade100, // Change to your desired color
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorWeight: 1,
                                        labelColor: Colors.black,
                                        labelStyle: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        unselectedLabelStyle:
                                            GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        indicatorColor: Colors.black87,
                                        tabs: [
                                          Tab(
                                              text:
                                                  "Likes ${formatNumber(state.data!.totalLikes)}"),
                                          Tab(
                                              text:
                                                  "Collections ${formatNumber(state.data!.totalCollections)}"),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    child: TabBarView(
                                  controller: _tabController,
                                  children: <Widget>[
                                    ExtendedVisibilityDetector(
                                        uniqueKey: const Key('Tab0'),
                                        child: AutomaticKeepAlive(
                                          child: BlocProvider(
                                            create: (_) => DI<CollectionsBloc>(
                                                param1: widget.userName),
                                            child: BlocBuilder<CollectionsBloc,
                                                    ListState<Collection>>(
                                                builder: (context, state) {
                                              return CustomScrollView(
                                                physics: physics,
                                                slivers: [
                                                  SliverList(
                                                      delegate:
                                                          SliverChildBuilderDelegate(
                                                              (context, index) {
                                                    return CollectionItem(
                                                      collection:
                                                          state.data[index],
                                                    );
                                                  },
                                                              childCount: state
                                                                  .data
                                                                  .length)),
                                                  const FooterLocator.sliver(),
                                                ],
                                              );
                                            }),
                                          ),
                                        )),
                                    ExtendedVisibilityDetector(
                                        uniqueKey: const Key('Tab1'),
                                        child: AutomaticKeepAlive(
                                          child: BlocProvider(
                                            create: (_) => DI<UserLikesBloc>(
                                                param1: widget.userName),
                                            child: BlocBuilder<UserLikesBloc,
                                                    ListState<Photo>>(
                                                builder: (context, state) {
                                              return CustomScrollView(
                                                physics: physics,
                                                slivers: [
                                                  SliverMasonryGrid.count(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 5.0,
                                                    crossAxisSpacing: 5.0,
                                                    childCount:
                                                        state.data.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      Photo photo =
                                                          state.data[index];
                                                      return ImageTile(
                                                        photo: photo,
                                                        onTap: () =>
                                                            handleTap(photo),
                                                        onDoubleTap: () => {},
                                                      );
                                                    },
                                                  ),
                                                  const FooterLocator.sliver(),
                                                ],
                                              );
                                            }),
                                          ),
                                        )),
                                  ],
                                ))
                              ])));
                    });
              }
            })));
  }
}

Widget _buildStatColumn(String count, String label) {
  return Column(
    children: [
      Text(count,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
      Text(label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          )),
    ],
  );
}

class Background extends StatelessWidget {
  final User user;
  const Background({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Colors.transparent,
                      Color.fromARGB(239, 19, 17, 17)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // stops: [0, 0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: RemoteImage(
                  url:
                      'https://images.unsplash.com/photo-1547366785-564103df7e13?q=80&w=2459&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ))),
        Padding(
          padding: const EdgeInsets.only(top: 95.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(width: 25),
                CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profileImage.medium)),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    user.name,
                    style: GoogleFonts.roboto(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(user.location ?? 'No location',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      )),
                ]),
              ]),
              const SizedBox(height: 16),
              Text(user.bio ?? 'No bio',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    _buildStatColumn(
                        formatNumber(user.followersCount), 'followers'),
                    const SizedBox(width: 16),
                    _buildStatColumn(
                        formatNumber(user.followingCount), 'following'),
                    const SizedBox(width: 16),
                    _buildStatColumn(formatNumber(user.downloads), 'downloads'),
                  ]),
                  SvgPicture.asset(
                    'assets/ins.svg',
                    width: 30,
                    height: 30,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SlideInTitle extends StatefulWidget {
  final Widget child;

  const SlideInTitle({
    super.key,
    required this.child,
  });
  @override
  _SlideInTitleState createState() {
    return _SlideInTitleState();
  }
}

class _SlideInTitleState extends State<SlideInTitle> {
  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    return Visibility(
      visible: visible,
      child: widget.child,
    );
  }
}

class AutomaticKeepAlive extends StatefulWidget {
  final Widget child;

  const AutomaticKeepAlive({
    super.key,
    required this.child,
  });

  @override
  State<AutomaticKeepAlive> createState() => AutomaticKeepAliveState();
}

class AutomaticKeepAliveState extends State<AutomaticKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
