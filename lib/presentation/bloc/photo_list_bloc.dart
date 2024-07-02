import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapgallery/core/util.dart';

import '../../core/base_state.dart';
import '../../domain/entity/photo/photo.dart';
import '../../domain/usecase/get_photos.dart';

abstract class PhotoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PhotoListMore extends PhotoListEvent {
  PhotoListMore();
}

final class PhotoListRefresh extends PhotoListEvent {
  PhotoListRefresh();
}

class MainPhotoListBloc extends Bloc<PhotoListEvent, ListState<Photo>> {
  final GetPhotos getPhotos;
  final String orderBy;
  MainPhotoListBloc({required this.getPhotos, required this.orderBy})
      : super(const ListState<Photo>()) {
    on<PhotoListRefresh>(_refresh);
    on<PhotoListMore>(_loadmore);

    add(PhotoListRefresh());
  }

  Future<void> _refresh(
      PhotoListRefresh event, Emitter<ListState<Photo>> emit) async {
    emit(state.copyWith(status: ListStatus.refreshing));
    try {
      List<Photo> newPhotos = await getPhotos(orderBy, 1);
      emit(state.copyWith(
          status: ListStatus.success, data: newPhotos, currentPage: 1));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.refreshError, errorMessage: e.toString()));
    }
  }

  Future<void> _loadmore(
      PhotoListMore event, Emitter<ListState<Photo>> emit) async {
    emit(state.copyWith(status: ListStatus.loadingMore));
    int pageToLoad = state.currentPage + 1;
    try {
      List<Photo> newPhotos = await getPhotos(orderBy, pageToLoad);
      emit(state.copyWith(
          status: ListStatus.success,
          data: mergeUniquePhoto(state.data, newPhotos),
          currentPage: pageToLoad));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.loadMoreError, errorMessage: e.toString()));
    }
  }
}
