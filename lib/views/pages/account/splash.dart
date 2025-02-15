import 'dart:async';
import 'package:dio/dio.dart';
import 'package:duowoo/views/mixins/upgrade_minxin.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/views/pages/review/review.dart';
import 'package:duowoo/views/pages/account/login.dart';
import 'package:duowoo/server/api/account_api.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with LoginMixin, UpgradeMixin {
  bool _isLoggedIn = true;
  final jpush = JPush();
  final dio = Dio();
  final log = Logger(printer: PrettyPrinter());
  final accountApi = AccountApi();

  @override
  void initState() {
    super.initState();
    initJPush();
    _startTimer();
    upgrade();
  }

  void initJPush() {
    try {
      jpush.setAuth(enable: true);
      jpush.setup(
        appKey: "4f7cd06d248b876d0be2ff06", //你自己应用的 AppKey
        channel: "theChannel",
        production: false,
        debug: false,
      );
      jpush.applyPushAuthority(
          NotificationSettingsIOS(sound: true, alert: true, badge: true));
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {},
          onOpenNotification: (Map<String, dynamic> message) async {
            Navigator.pushNamed(context, "/review"); // 使用Navigator导航到指定页面
          },
          onReceiveMessage: (Map<String, dynamic> message) async {},
          onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {},
          onNotifyMessageUnShow: (Map<String, dynamic> message) async {},
          onInAppMessageShow: (Map<String, dynamic> message) async {},
          onCommandResult: (Map<String, dynamic> message) async {},
          onInAppMessageClick: (Map<String, dynamic> message) async {},
          onConnected: (Map<String, dynamic> message) async {});
    } on PlatformException {
      //
    }
  }

  int _counter = 3;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      _counter--;
      if (_counter == 0) {
        timer.cancel();
        var account = await getAccountInfo();
        if (account == null) {
          _isLoggedIn = false;
        }
        if (!_isLoggedIn) {
          try {
            var resp = await dio.get("https://www.baidu.com/");
            log.d(resp.toString());
          } catch (e) {
            log.d('发生了错误: $e');
          }
        }
        _navigateToPage(_isLoggedIn);
      }
      setState(() {});
    });
  }

  void _navigateToPage(isLoggedIn) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => isLoggedIn ? ReviewPage() : const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("启动页，会放一些操作指导，或宣传信息($_counter)"),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Or a simple text like "Loading..."
          ],
        ),
      ),
    );
  }
}
