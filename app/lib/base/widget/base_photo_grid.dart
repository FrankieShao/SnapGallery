import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:app/ui/photo_detail/photo_detail_page.dart';
import 'image_title.dart';

abstract class BasePhotoGrid<B extends BlocBase<ListState<Photo>>>
    extends StatefulWidget {
  const BasePhotoGrid({super.key});
}

abstract class BasePhotoGridState<B extends BlocBase<ListState<Photo>>>
    extends State<BasePhotoGrid<B>> with AutomaticKeepAliveClientMixin {
  void onRefresh();
  void onLoad();
  final EasyRefreshController _controller =
      EasyRefreshController(controlFinishRefresh: true);

  void handleTap(Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoDetailPage(photo: photo)),
    );
  }

  void handleDoubleTap(Photo url) {
    print('Double-tapped on $url');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<B, ListState<Photo>>(
      listener: (context, state) {
        switch (state.status) {
          case ListStatus.refreshing:
            _controller.callRefresh();
            break;
          case ListStatus.loadingMore:
            _controller.callLoad();
            break;
          case ListStatus.refreshError:
            _controller.finishRefresh(IndicatorResult.fail);
            break;
          case ListStatus.loadMoreError:
            _controller.finishLoad(IndicatorResult.fail);
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<B, ListState<Photo>>(builder: (context, state) {
        return EasyRefresh(
            header: const ClassicHeader(
              dragText: 'Pull to refresh',
              armedText: 'Release ready',
              readyText: 'Refreshing...',
              processingText: 'Refreshing...',
              processedText: 'Succeeded',
              noMoreText: 'No more',
              failedText: 'Failed',
              messageText: 'Last updated at %T',
              safeArea: false,
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
            callRefreshOverOffset: 40,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                    padding: const EdgeInsets.all(3.0),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Photo photo = state.data[index];
                        return ImageTile(
                          photo: photo,
                          onTap: () => handleTap(photo),
                          onDoubleTap: () => handleDoubleTap(photo),
                        );
                      },
                    )),
                const FooterLocator.sliver(),
              ],
            ),
            onRefresh: () async {
              onRefresh();
            },
            onLoad: () async {
              onLoad();
            });
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
