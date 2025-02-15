import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool showDrawer;
  const CustomAppBar(this.title, this.actions, this.showDrawer, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0XFFDFD3C3),
        title: Text(title),
        leading: showDrawer
            ? Builder(
                // 使用 Builder 来获取 BuildContext
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : Text(""),
        titleTextStyle: TextStyle(
            fontFamily: "",
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 20),
        toolbarTextStyle: TextStyle(fontFamily: "", color: Colors.teal),
        actions: this.actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
