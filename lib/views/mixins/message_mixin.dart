import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

mixin MessageMixin<T extends StatefulWidget> {
  static String errNetwork= "err_network";
  static String errApi= "err_api";

  void mxShowSnackbar(
      String message, ContentType contentType, BuildContext context) {
    var title = "成功啦";
    if (contentType != ContentType.success) {
      title = "失败啦";
    }
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
