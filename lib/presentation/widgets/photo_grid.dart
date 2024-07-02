import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapgallery/presentation/bloc/photo_list_bloc.dart';
import 'package:snapgallery/presentation/bloc/topic_photo_bloc.dart';
import 'package:snapgallery/presentation/bloc/user_likes_bloc.dart';
import 'package:snapgallery/presentation/widgets/base_photo_grid.dart';

class MainPhotoGrid extends BasePhotoGrid<MainPhotoListBloc> {
  const MainPhotoGrid({super.key});

  @override
  _MainPhotoGridState createState() => _MainPhotoGridState();
}

class _MainPhotoGridState extends BasePhotoGridState<MainPhotoListBloc> {
  @override
  void onRefresh() {
    context.read<MainPhotoListBloc>().add(PhotoListRefresh());
  }

  @override
  void onLoad() {
    context.read<MainPhotoListBloc>().add(PhotoListMore());
  }
}

class TopicPhotoGrid extends BasePhotoGrid<TopicPhotoBloc> {
  const TopicPhotoGrid({super.key});

  @override
  _TopicPhotoGridState createState() => _TopicPhotoGridState();
}

class _TopicPhotoGridState extends BasePhotoGridState<TopicPhotoBloc> {
  @override
  void onRefresh() {
    context.read<TopicPhotoBloc>().add(TopicPhotoRefresh());
  }

  @override
  void onLoad() {
    context.read<TopicPhotoBloc>().add(TopicPhotoMore());
  }
}

class UserLikesGrid extends BasePhotoGrid<UserLikesBloc> {
  const UserLikesGrid({super.key});

  @override
  _UserLikesGridState createState() => _UserLikesGridState();
}

class _UserLikesGridState extends BasePhotoGridState<UserLikesBloc> {
  @override
  void onRefresh() {
    context.read<UserLikesBloc>().add(PhotoLikesRefresh());
  }

  @override
  void onLoad() {
    context.read<UserLikesBloc>().add(PhotoLikesMore());
  }
}
