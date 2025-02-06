import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jiwa/pages/login.dart';
import 'package:jiwa/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _startTimer();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  int _counter = 5;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
        if (_counter == 0) {
          timer.cancel();
          _navigateToPage();
        }
      });
    });
  }

  void _navigateToPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              _isLoggedIn ? const HomePage(title: '鸡娃') : const LoginPage()),
    );
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate a delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with your logo asset path
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Or a simple text like "Loading..."
          ],
        ),
      ),
    );
  }
}
