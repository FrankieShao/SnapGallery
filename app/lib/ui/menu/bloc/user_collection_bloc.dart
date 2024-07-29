import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util.dart';

abstract class CollectionListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CollectionsMore extends CollectionListEvent {
  CollectionsMore();
}

final class CollectionsRefresh extends CollectionListEvent {
  CollectionsRefresh();
}

class CollectionsBloc extends Bloc<CollectionListEvent, ListState<Collection>> {
  final GetUserCollections getUserCollections;
  final GetCollectionPhotos getCollectionPhotos;
  final String userName;

  CollectionsBloc(
      {required this.getUserCollections,
      required this.getCollectionPhotos,
      required this.userName})
      : super(const ListState<Collection>()) {
    on<CollectionsRefresh>(_refresh);
    on<CollectionsMore>(_loadmore);

    add(CollectionsRefresh());
  }

  Future<void> _refresh(
      CollectionsRefresh event, Emitter<ListState<Collection>> emit) async {
    emit(state.copyWith(status: ListStatus.refreshing));
    try {
      List<Collection> collections = await getUserCollections(userName, 1);
      emit(state.copyWith(
          status: collections.length < 20
              ? ListStatus.loadNoMore
              : ListStatus.success,
          data: collections,
          currentPage: 1));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.refreshError, errorMessage: e.toString()));
    }
  }

  Future<void> _loadmore(
      CollectionsMore event, Emitter<ListState<Collection>> emit) async {
    emit(state.copyWith(status: ListStatus.loadingMore));
    int pageToLoad = state.currentPage + 1;
    try {
      List<Collection> collections =
          await getUserCollections(userName, pageToLoad);
      emit(state.copyWith(
          status: collections.length < 20
              ? ListStatus.loadNoMore
              : ListStatus.success,
          data: mergeUniqueCollection(state.data, collections),
          currentPage: pageToLoad));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.loadMoreError, errorMessage: e.toString()));
    }
  }
}
