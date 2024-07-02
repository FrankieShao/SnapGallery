import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapgallery/core/base_state.dart';
import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/presentation/bloc/user_collection_bloc.dart';
import 'package:snapgallery/presentation/widgets/remote_image.dart';

class UserCollectionList extends StatefulWidget {
  const UserCollectionList({Key? key});

  @override
  _UserCollectionListState createState() => _UserCollectionListState();
}

class _UserCollectionListState extends State<UserCollectionList>
    with AutomaticKeepAliveClientMixin {
  final EasyRefreshController _controller =
      EasyRefreshController(controlFinishLoad: true);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<CollectionsBloc, ListState<Collection>>(
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
          case ListStatus.loadNoMore:
            _controller.finishLoad(IndicatorResult.noMore, true);
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<CollectionsBloc, ListState<Collection>>(
          builder: (context, state) {
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
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CollectionItem(collection: state.data[index]);
                    },
                    childCount: state.data.length,
                  ),
                ),
                const FooterLocator.sliver(),
              ],
            ),
            onRefresh: () async {
              context.read<CollectionsBloc>().add(CollectionsRefresh());
            },
            onLoad: () async {
              context.read<CollectionsBloc>().add(CollectionsMore());
            });
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserCollectionListWithoutRefresh extends StatelessWidget {
  final EasyRefreshController controller;

  const UserCollectionListWithoutRefresh({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionsBloc, ListState<Collection>>(
        listener: (context, state) {
      switch (state.status) {
        case ListStatus.refreshError:
          controller.finishRefresh(IndicatorResult.fail);
          break;
        case ListStatus.loadMoreError:
          controller.finishLoad(IndicatorResult.fail);
          break;
        case ListStatus.loadNoMore:
          controller.finishLoad(IndicatorResult.noMore, true);
          break;
        default:
          break;
      }
    }, child: BlocBuilder<CollectionsBloc, ListState<Collection>>(
            builder: (context, state) {
      return ListView.builder(
        key: PageStorageKey<String>(key.toString()),
        itemCount: state.data.length,
        itemBuilder: (context, index) {
          return CollectionItem(collection: state.data[index]);
        },
      );
    }));
  }
}

class CollectionItem extends StatelessWidget {
  final Collection collection;
  const CollectionItem({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final List<String>? imageUrls =
        collection.previewPhotos?.map((e) => e.urls.small).toList();
    return GestureDetector(
      onTap: () {
        //Navigator.of(context).pushNamed('/collection', arguments: collection);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 200.0,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: RemoteImage(
                                    url: imageUrls?.elementAtOrNull(0),
                                    width: double.infinity,
                                  )),
                              const SizedBox(height: 2),
                              Expanded(
                                  flex: 1,
                                  child: RemoteImage(
                                    width: double.infinity,
                                    url: imageUrls?.elementAtOrNull(1),
                                  )),
                            ],
                          ),
                        )),
                    const SizedBox(width: 2),
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 200.0,
                          child: RemoteImage(
                            url: imageUrls?.elementAtOrNull(2),
                          )),
                    ),
                  ],
                ),
                // Bottom part with text and arrow
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collection.title,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${collection.totalPhotos} images •  Curated by Frank Shaw",
                            style: GoogleFonts.roboto(
                              fontSize: 11,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
