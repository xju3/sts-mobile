import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/views/pages/home.dart';
import 'package:duowoo/views/pages/review/assignment.dart';
import 'package:duowoo/views/pages/review/review.dart';
import 'package:duowoo/views/pages/settings/home.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDraw extends StatefulWidget {
  const CustomDraw({Key? key}) : super(key: key);

  @override
  State<CustomDraw> createState() => _CustomDrawState();
}

class _CustomDrawState extends State<CustomDraw> with LoginMixin {
  var currStudentName = "";
  var schoolName = "";
  var otherStudents = [];

  void goto(BuildContext ctx, dynamic page) {
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> switchStudents(String studentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("studentId", studentId);
    var acc = await getAccountInfo();
    var students = acc?.students;
    if (students == null || students.isEmpty) {
      return;
    }
    var currStudent = students.firstWhere((element) => element.id == studentId);
    currStudentName = currStudent.name ?? "";
    schoolName = currStudent.schoolName ?? "";
    otherStudents =
        students.where((element) => element.id != studentId).toList();
    setState(() {});
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currStudentId = prefs.getString("studentId");
    if (currStudentId == null) return;
    await switchStudents(currStudentId);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                backgroundBlendMode: BlendMode.darken,
              ),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '$currStudentName的小助手',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      if (otherStudents.isNotEmpty)
                        Expanded(
                          child: SizedBox(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: otherStudents.length,
                              itemBuilder: (BuildContext context, int index) {
                                final student = otherStudents[index];
                                return GestureDetector(
                                  onTap: () {
                                    switchStudents(student.id!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        student.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Ionicons.school_outline,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        schoolName,
                        style:
                            TextStyle(fontSize: 14, color: Color(0XFFF8F5E9)),
                      ),
                    ],
                  ),
                ],
              )),
          GestureDetector(
            onTap: () => goto(context, HomePage()),
            child: ListTile(
              leading: Icon(
                FluentIcons.home_24_regular,
              ),
              title: Text('首页'),
            ),
          ),
          GestureDetector(
            onTap: () => goto(context, ReviewPage()),
            child: ListTile(
              leading: Icon(
                FluentIcons.task_list_rtl_24_regular,
              ),
              title: Text('作业'),
            ),
          ),
          GestureDetector(
            onTap: () => goto(context, AssignmentPage()),
            child: ListTile(
              leading: Icon(FluentIcons.document_text_extract_24_regular),
              title: Text('练习'),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(FluentIcons.settings_24_regular),
              title: Text('设置'),
            ),
            onTap: () => goto(context, SettingPage()),
          )
        ],
      ),
    );
  }
}
