import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:snapgallery/auth/auth_service.dart';
import 'package:snapgallery/config.dart';
import 'package:snapgallery/core/base_state.dart';
import 'package:snapgallery/domain/entity/topic.dart';
import 'package:snapgallery/injection_container.dart';
import 'package:snapgallery/presentation/bloc/photo_list_bloc.dart';
import 'package:snapgallery/presentation/bloc/topic_photo_bloc.dart';
import 'package:snapgallery/presentation/cubit/topics_cubit.dart';
import 'package:snapgallery/presentation/widgets/app_bar.dart';
import 'package:snapgallery/presentation/widgets/photo_grid.dart';

/// Main page of the app
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex = 0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDrawerTap() {
    if (Config.isMockData) {
      DI<ZoomDrawerController>().toggle?.call();
    } else {
      AuthService authService = DI<AuthService>();
      if (authService.isLoggedIn()) {
        DI<ZoomDrawerController>().toggle?.call();
      } else {
        authService.login(context);
      }
    }
  }

  void _onTabChanged(int index, Topic topic) {
    setState(() {
      _currentTabIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
          BlocBuilder<TopicsCubit, ListState<Topic>>(builder: (context, state) {
        return Container(
            color: Colors.grey.shade100,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SGAppBar(
                      tabIndex: _currentTabIndex,
                      topics: state.data,
                      onTabChanged: (pair) {
                        _onTabChanged(pair.first, pair.second);
                      },
                      onDrawerTap: () => _onDrawerTap(),
                      onSearchTap: () {}),
                ];
              },
              body: PageView.custom(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentTabIndex = page;
                    });
                  },
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < 2) {
                        return BlocProvider(
                          create: (_) => DI<MainPhotoListBloc>(
                              param1: state.data[index].slug),
                          child: const MainPhotoGrid(),
                        );
                      } else {
                        return BlocProvider(
                          create: (_) => DI<TopicPhotoBloc>(
                              param1: state.data[index].slug),
                          child: const TopicPhotoGrid(),
                        );
                      }
                    },
                    childCount: state.data.length,
                  )),
            ));
      }),
    );
  }
}
