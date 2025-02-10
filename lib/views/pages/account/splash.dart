import 'dart:async';
import 'package:dio/dio.dart';
import 'package:duowoo/views/pages/home.dart';
import 'package:duowoo/views/pages/review/review.dart';

import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/pages/account/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:duowoo/server/api/account_api.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoggedIn = true;
  final dio = Dio();
  final log = Logger(printer: PrettyPrinter());
  final accountApi = AccountApi();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }


  Future<String> checkInternetConnection() async {
    var resp = await dio.get("https://www.baidu.com");
    return resp.toString();
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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var studentId = prefs.getString('studentId');
          var studentName = prefs.getString('studentName') ?? "";
          if (studentId == null) {
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
          _navigateToPage(_isLoggedIn, studentName);
        }
        setState(() { });
    });
  }

  void _navigateToPage(isLoggedIn, studentName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
          isLoggedIn ? ReviewPage() : const LoginPage()),
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
