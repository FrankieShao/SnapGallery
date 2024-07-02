import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapgallery/core/util.dart';
import 'package:snapgallery/domain/usecase/get_topic_photos.dart';

import '../../core/base_state.dart';
import '../../domain/entity/photo/photo.dart';

abstract class TopicPhotoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class TopicPhotoMore extends TopicPhotoEvent {
  TopicPhotoMore();
}

final class TopicPhotoRefresh extends TopicPhotoEvent {
  TopicPhotoRefresh();
}

class TopicPhotoBloc extends Bloc<TopicPhotoEvent, ListState<Photo>> {
  final GetTopicPhotos getTopicPhotos;
  final String topicSlug;

  TopicPhotoBloc({required this.getTopicPhotos, required this.topicSlug})
      : super(const ListState<Photo>()) {
    on<TopicPhotoRefresh>(_refresh);
    on<TopicPhotoMore>(_loadmore);
    add(TopicPhotoRefresh());
  }

  Future<void> _refresh(
      TopicPhotoRefresh event, Emitter<ListState<Photo>> emit) async {
    emit(state.copyWith(status: ListStatus.refreshing));
    try {
      List<Photo> newPhotos = await getTopicPhotos(topicSlug, 1);
      emit(state.copyWith(
          status: ListStatus.success, data: newPhotos, currentPage: 1));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.refreshError, errorMessage: e.toString()));
    }
  }

  Future<void> _loadmore(
      TopicPhotoMore event, Emitter<ListState<Photo>> emit) async {
    emit(state.copyWith(status: ListStatus.loadingMore));
    int pageToLoad = state.currentPage + 1;
    try {
      List<Photo> newPhotos = await getTopicPhotos(topicSlug, pageToLoad);
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
