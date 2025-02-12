import 'package:duowoo/views/mixins/common_mixin.dart';
import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:duowoo/views/widgets/menu_draw.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/mixins/image_picker_mixin.dart';
import 'package:duowoo/views/mixins/review_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with ImagePickerMixin, ReviewMixin, StringMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar("首页", [], true),
        drawer: CustomDraw(),
        body: Text("hello."));
  }
}
