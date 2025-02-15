import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/views/pages/account/parent.dart';
import 'package:duowoo/views/pages/account/student.dart';
import 'package:duowoo/views/pages/settings/web.dart';
import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../widgets/menu_draw.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("设置", [], true),
      drawer: CustomDraw(),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(FluentIcons.apps_add_in_24_regular),
            title: const Text('增加家长'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParentAccountPage()));
            },
          ),
          ListTile(
            leading: const Icon(FluentIcons.person_board_add_24_regular),
            title: const Text('增加学生'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudentPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: const Text('帮助'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebPage(
                          url: "http://app.aeons.me/app/help.html",
                          title: "帮助")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('隐私政策'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebPage(
                          url: "http://app.aeons.me/app/privacy.html",
                          title: "隐私政策")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('关于'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebPage(
                          url: "http://app.aeons.me/app/about.html",
                          title: "关于")));
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('退出登录'),
              onTap: () => logout(context)),
        ],
      ),
    );
  }
}
