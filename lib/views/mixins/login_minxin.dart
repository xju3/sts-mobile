import 'dart:io';
import 'dart:convert';
import 'package:duowoo/server/model/login_history.dart';
import 'package:duowoo/views/pages/account/splash.dart';
import 'package:duowoo/views/pages/review/review.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/account.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin LoginMixin<T extends StatefulWidget> {
  void setNotificationId(
      AccountApi accountApi, JPush jpush, String? parentId) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    if (null == parentId) return;
    jpush.getRegistrationID().then((rid) async {
      var deviceId = 'ios';
      if (Platform.isAndroid) {
        deviceId = 'android';
      }
      var history = LoginHistory(
          parentId: parentId, notificationId: rid, deviceId: deviceId);
      accountApi.createLoginHistory(history);
    });
  }

  Future<AccountInfo?> getAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("account");
    if (jsonString != null) {
      var map = jsonDecode(jsonString) as Map<String, dynamic>;
      return AccountInfo.fromJson(map);
    }
    return null;
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('account');
    await prefs.remove('studentId');
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashPage()),
    );
  }

  void loginHandler(JPush jpush, AccountApi accountApi, AccountInfo accountInfo,
      BuildContext context, Function? onAccountNotFound) async {
    if (accountInfo.parent?.name == null) {
      if (onAccountNotFound != null) onAccountNotFound();
      return;
    }
    setNotificationId(accountApi, jpush, accountInfo.parent?.id);
    var students = accountInfo.students;
    if (students == null || students.isEmpty) return;
    var studentId = students[0].id!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(accountInfo);
    await prefs.setString('account', jsonString);
    await prefs.setString('studentId', studentId);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage()),
    );
  }
}
