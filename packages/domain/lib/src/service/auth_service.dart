import 'package:flutter/material.dart';

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
