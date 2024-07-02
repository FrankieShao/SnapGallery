import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapgallery/core/base_state.dart';
import 'package:snapgallery/domain/entity/topic.dart';
import 'package:snapgallery/domain/usecase/get_topics.dart';

class TopicsCubit extends Cubit<ListState<Topic>> {
  final GetTopics getTopics;

  TopicsCubit(this.getTopics)
      : super(ListState<Topic>(data: [
          Topic(
              id: "",
              title: 'Popular',
              slug: 'popular',
              description: '',
              status: ''),
          Topic(
              id: "",
              title: 'Latest',
              slug: 'latest',
              description: '',
              status: ''),
        ])) {
    fetch();
  }

  Future<void> fetch() async {
    emit(state.copyWith(status: ListStatus.refreshing));
    try {
      List<Topic> topics = await getTopics();
      emit(state.copyWith(
          status: ListStatus.success, data: [...state.data, ...topics]));
    } catch (e) {
      emit(state.copyWith(
          status: ListStatus.refreshError, errorMessage: e.toString()));
    }
  }
}
