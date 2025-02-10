import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('语言'),
            onTap: () {
              // TODO: Implement language selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('通知'),
            onTap: () {
              // TODO: Implement notification settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('隐私政策'),
            onTap: () {
              // TODO: Implement privacy policy view
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('关于'),
            onTap: () {
              // TODO: Implement about page
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('退出登录'),
              onTap: () => mxLogout(context)),
        ],
      ),
    );
  }
}
