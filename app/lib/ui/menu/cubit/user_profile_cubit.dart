import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/constants.dart';

class UserProfileCubit extends Cubit<DataState<User>> {
  final String userName;
  final GetUser getUser;
  final AuthService authService;

  UserProfileCubit(
      {required this.userName,
      required this.authService,
      required this.getUser})
      : super(const DataState<User>()) {
    if (userName == Constants.ME) {
      if (BuildConfig.isMockData) {
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
