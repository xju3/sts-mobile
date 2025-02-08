import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T> {
  var deviceConnected = true;
  // late StreamSubscription? subscription;

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    // if (null != subscription) {
    //   subscription!.isPaused;
    //   subscription!.cancel();
    // }
    super.dispose();
  }

  // Future<void> subscribeInternetConnection() async {
  //   subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result)  {
  //     if (result != ConnectivityResult.none) {
  //       InternetConnectionChecker().hasConnection.then((value) {
  //         if (!value) {
  //           Flushbar(
  //             title:  '网络异常提醒',
  //             message:  "当前设备已断开了网络连接.",
  //             duration:  const Duration(seconds: 3),
  //           ).show(context);
  //         }
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    FBroadcast.instance().register("api_info", (value, callback) {
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
