import 'package:duowoo/views/mixins/message_mixin.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T> {
  var deviceConnected = true;
  // late StreamSubscription? subscription;

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }

  @override
  void initState() {
    FBroadcast.instance().register(MessageMixin.errApi, (value, callback) {
      Fluttertoast.showToast(
          msg: value,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
    });
    // subscribeInternetConnection();
    super.initState();
  }
}
