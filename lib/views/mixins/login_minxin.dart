import 'dart:io';
import 'dart:convert';
import 'package:duowoo/server/model/login_history.dart';
import 'package:duowoo/views/pages/account/splash.dart';
import 'package:duowoo/views/pages/review/review.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/account.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin LoginMixin<T extends StatefulWidget> {
  Future<void> initPlatformState(JPush jpush, AccountApi accountApi,
      String? parentId, BuildContext context) async {
    if (parentId == null) return;

    try {
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

    jpush.setAuth(enable: true);
    jpush.setup(
      appKey: "4f7cd06d248b876d0be2ff06", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: false,
    );
    jpush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
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

  void mxLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('account');
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashPage()),
    );
  }

  void mxLoginHandler(
      JPush jpush,
      AccountApi accountApi,
      AccountInfo accountInfo,
      BuildContext context,
      Function? onAccountNotFound) async {
    if (accountInfo.parent?.name == null) {
      if (onAccountNotFound != null) onAccountNotFound();
      return;
    }
    var students = accountInfo.students;
    if (students == null || students.isEmpty) return;
    var studentId = students[0].id!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(accountInfo);

    await prefs.setString('account', jsonString);
    await prefs.setString('studentId', studentId);
    await initPlatformState(jpush, accountApi, accountInfo.parent?.id, context);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage()),
    );
  }
}
