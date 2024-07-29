import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/auth/login_page.dart';

class AuthServiceImpl implements AuthService {
  bool isLogin = false;
  String bear = '';
  String name = '';

  final List<VoidCallback> _callbacks = [];

  @override
  void addLoginCallback(VoidCallback callback) {
    _callbacks.add(callback);
  }

  @override
  void removeLoginCallback(VoidCallback callback) {
    _callbacks.remove(callback);
  }

  @override
  String getBear() {
    return bear;
  }

  @override
  bool isLoggedIn() {
    return BuildConfig.isMockData || isLogin;
  }

  @override
  Future<void> logout() {
    isLogin = false;
    bear = '';
    return Future.value();
  }

  @override
  void loginSuccess(String bear, String name) {
    this.isLogin = true;
    this.bear = bear;
    this.name = name;
    for (final callback in _callbacks) {
      callback();
    }
  }

  @override
  void login(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => const LoginBottomSheet(),
    );
  }

  @override
  String getName() {
    return name;
  }
}
