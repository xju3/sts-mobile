import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../server/model/option.dart';

mixin StringMixin<T extends StatefulWidget> {
  var df1 = DateFormat("MMdd");
  var df2 = DateFormat("yyyy-MM-dd");
  var df3 = DateFormat("yyyy-MM-dd HH:mm");

  String getText(dynamic val) {
    if (null == val) return "";
    return val;
  }

  bool getBool(int? val) {
    if (null == val || val == 0) return false;
    return true;
  }

  List<String> getOptionIds(List<Option>? val) {
    if (null == val) return [];
    return val.map((e) => e.value!).toList();
  }

  String getOptionTexts(List<Option>? val) {
    if (null == val) return "";
    return val.map((e) => e.label!).toList().join(",");
  }

  String getDateTime(DateTime? val) {
    if (val == null) return "无数据";
    return df2.format(val);
  }

  String getDateTimeRangeText(DateTime? d1, DateTime? d2) {
    if (d1 == null || d2 == null) return "";
    return "从${df3.format(d1)}到${df3.format(d2)}";
  }

  String getDateTimeMinSec(DateTime? val) {
    if (val == null) return "";
    return df3.format(val);
  }

  String getMonthDay(DateTime? val) {
    if (null == val) return '';
    return df1.format(val);
  }



  bool isImage(String url) {
    var ext = url.split('.').last;
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext.toLowerCase())) return true;
    return false;
  }
}

mixin MessageMixin {
  static String qrMessage = "qr_message";
  static String errMessage = "qr_message";
}





mixin CommonMixin<T extends StatefulWidget> on State<T> {
  Widget emptyWidget(String title, String subTitle) {
    return Text("hello");
  }


  Color getSelectedColor(bool selected) {
    if (selected) return Colors.blueGrey;
    return Colors.black54;
  }



  double roundupDivide(int a, int b) {
    var val = a / b;
    var remain = a % b;
    if (remain > 0) return val.ceil().toDouble();
    return val;
  }
}
