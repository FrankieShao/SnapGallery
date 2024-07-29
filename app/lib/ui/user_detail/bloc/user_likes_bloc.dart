import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util.dart';

abstract class LikeListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PhotoLikesMore extends LikeListEvent {
  PhotoLikesMore();
}

final class PhotoLikesRefresh extends LikeListEvent {
  PhotoLikesRefresh();
}

class UserLikesBloc extends Bloc<LikeListEvent, ListState<Photo>> {
  final GetUserLikes getUserLikes;
  final String userName;

  UserLikesBloc({required this.getUserLikes, required this.userName})
      : super(const ListState<Photo>()) {
    on<PhotoLikesRefresh>(_refresh);
    on<PhotoLikesMore>(_loadmore);

    add(PhotoLikesRefresh());
  }

  Future<void> _refresh(
      PhotoLikesRefresh event, Emitter<ListState<Photo>> emit) async {
    emit(state.copyWith(status: ListStatus.refreshing));
    try {
      List<Photo> newPhotos = await getUserLikes(userName, 1);
      emit(state.copyWith(
          status: ListStatus.success, data: newPhotos, currentPage: 1));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.refreshError, errorMessage: e.toString()));
    }
  }

  Future<void> _loadmore(
      PhotoLikesMore event, Emitter<ListState<Photo>> emit) async {
    emit(state.copyWith(status: ListStatus.loadingMore));
    int pageToLoad = state.currentPage + 1;
    try {
      List<Photo> newPhotos = await getUserLikes(userName, pageToLoad);
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
