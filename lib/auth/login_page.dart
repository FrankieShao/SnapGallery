import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:snapgallery/auth/auth_service.dart';
import 'package:snapgallery/injection_container.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height:
          MediaQuery.of(context).size.height * 0.9, // Adjust height as needed
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  final String clientId = dotenv.env['ACCESS_KEY']!;
  final String clientSecret = dotenv.env['SECRET_KEY']!;
  final String redirectUri = dotenv.env['REDIRECT_URI']!;

  final String authorizationEndpoint = 'https://unsplash.com/oauth/authorize';
  final String tokenEndpoint = 'https://unsplash.com/oauth/token';

  late StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.startsWith(authorizationEndpoint)) {
        _handleAuthCode(url);
      }
    });
  }

  void _handleAuthCode(String url) {
    final Uri uri = Uri.parse(url);
    final String? authCode = uri.queryParameters['code'];
    if (authCode != null) {
      _exchangeCodeForToken(authCode);
    }
  }

  Future<void> _exchangeCodeForToken(String code) async {
    final response = await DI<Dio>().post(
      tokenEndpoint,
      data: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'code': code,
        'grant_type': 'authorization_code',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final String accessToken = data['access_token'];
      final String userName = data['username'];
      // Save the access token and navigate to the next page
      DI<AuthService>().loginSuccess(accessToken, userName);
      Navigator.pop(context, true);
    } else {
      // login in error, show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please try again.'),
        ),
      );
      Navigator.pop(context, false);
    }
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String loginUrl =
        '$authorizationEndpoint?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections';

    return Scaffold(
      appBar: AppBar(title: const Text('Login with Unsplash')),
      body: WebviewScaffold(
        url: loginUrl,
        withJavascript: true,
        clearCookies: true,
        clearCache: true,
      ),
    );
  }
}
