import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapgallery/auth/auth_service.dart';
import 'package:snapgallery/config.dart';
import 'package:snapgallery/constants.dart';
import 'package:snapgallery/core/base_state.dart';
import 'package:snapgallery/domain/entity/user/user.dart';
import 'package:snapgallery/domain/usecase/get_user.dart';

class UserProfileCubit extends Cubit<DataState<User>> {
  final GetUser getUser;
  final AuthService authService;
  final String userName;

  UserProfileCubit(
      {required this.userName,
      required this.authService,
      required this.getUser})
      : super(const DataState<User>()) {
    if (userName == Constants.ME) {
      if (Config.isMockData) {
        fetch(Constants.ME);
      } else {
        authService.addLoginCallback(_loginCallback);
        if (authService.isLoggedIn()) {
          fetch(Constants.ME);
        } else {
          emit(state.copyWith(
              status: DataStatus.error, errorMessage: 'Not logged in'));
        }
      }
    } else {
      fetch(userName);
    }
  }

  void _loginCallback() {
    if (authService.isLoggedIn()) {
      fetch(Constants.ME);
    }
  }

  Future<void> fetch(String userName) async {
    emit(state.copyWith(status: DataStatus.loading));
    try {
      User user = await getUser(userName);
      emit(state.copyWith(data: user, status: DataStatus.success));
    } catch (e) {
      emit(
          state.copyWith(status: DataStatus.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    authService.removeLoginCallback(_loginCallback);
    return super.close();
  }
}
