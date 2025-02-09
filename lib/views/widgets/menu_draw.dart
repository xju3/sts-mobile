import 'package:duowoo/views/pages/home.dart';
import 'package:duowoo/views/pages/review/review.dart';
import 'package:flutter/material.dart';

class CustomDraw extends StatelessWidget {
  const CustomDraw({Key? key}) : super(key: key);

  void goto(BuildContext ctx, dynamic page) {
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(builder: (context) => page),
    );
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
            ),
            child: Text(
              '家庭作业小助手',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => goto(context, HomePage()),
            child: ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text('首页'),
            ),
          ),
          GestureDetector(
            onTap: () => goto(context, ReviewPage()),
            child: ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text('作业'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.incomplete_circle_rounded),
            title: Text('错题'),
          ),
          ListTile(
            leading: Icon(Icons.crop_square),
            title: Text('广场'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
          ),
        ],
      ),
    );
  }
}
