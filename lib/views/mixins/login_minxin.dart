import 'package:duowoo/views/pages/account/splash.dart';
import 'package:duowoo/views/pages/review/review.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin LoginMixin<T extends StatefulWidget> {
  void mxLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('studentId');
    await prefs.remove('studentName');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashPage()),
    );
  }

  void mxLoginHandler( AccountApi accountApi, AccountInfo? accountInfo,
      BuildContext context, Function? onAccountNotFound) async {
    if (accountInfo == null || accountInfo.parentName == null) {
      if (onAccountNotFound != null) onAccountNotFound();
      return;
    }
    //TODO: 目前不支持一个账号下多个学生
    var students = accountInfo.students;
    if (students == null || students.isEmpty) return;
    var student = students[0];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('studentId', student.id!);
    await prefs.setString('studentName', student.name!);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage()),
    );
  }
}
