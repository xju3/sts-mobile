import 'package:flutter/material.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:duowoo/views/pages/review/home.dart';

mixin LoginMixin<T extends StatefulWidget> {
  void loginHandler(String message, AccountApi accountApi,
      AccountInfo? accountInfo, BuildContext context) async {
    if (accountInfo == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    //TODO: 目前不支持一个账号下多个学生
    var students = accountInfo.students;
    if (students == null || students.isEmpty) return;
    var student = students[0];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('studentId', student.id!);
    await prefs.setString('studentName', student.name!);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(title: student.name!)),
    );
  }
}
