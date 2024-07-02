import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:snapgallery/auth/login_page.dart';

abstract class AuthService {
  void login(BuildContext context);
  Future<void> logout();
  bool isLoggedIn();
  void loginSuccess(String bear, String name);
  String getBear();
  String getName();
  void addLoginCallback(VoidCallback callback);
  void removeLoginCallback(VoidCallback callback);
}

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
    return isLogin;
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

abstract class TokenInjector {
  String getToken();
}

class TokenInjectorImpl implements TokenInjector {
  final AuthService _authService;

  TokenInjectorImpl(this._authService);

  @override
  String getToken() {
    if (_authService.isLoggedIn()) {
      return 'Bearer ${_authService.getBear()}';
    } else {
      return 'Client-ID ${dotenv.env['ACCESS_KEY']}';
    }
  }
}
