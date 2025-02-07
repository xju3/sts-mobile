import 'package:dio/dio.dart';
import 'package:duowa/server/model/result.dart';
import 'package:duowa/views/mixins/common_mixin.dart';
import 'package:duowa/server/api/constants.dart';
import 'package:duowa/server/model/err_msg.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor with MessageMixin {
  final Logger logger = Logger(printer: PrettyPrinter());

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.kToken);
    if (null != token) {
      options.headers.addAll({
        "Authorization": 'Bearer $token',
        'ngrok-skip-browser-warning': 'hello'
      });
    }
    handler.next(options);
  }

  void remoteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConstants.kToken);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e(err.message);
    FBroadcast.instance().broadcast(MessageMixin.errMessage, value: '网络请求失败.');
    // handler.next(err);
    if (err.response?.statusCode == 401) {
      remoteToken();
      return;
    }
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    logger.d(response);
    var map = jsonDecode(response.data);
    var result = Result.fromJson(map);
    var err = result.err;
    if (err == null || err.code == null || err.code != '0') {
      FBroadcast.instance().broadcast(MessageMixin.errMessage, value: "");
      return;
    }
    response.data = result.data;
    handler.next(response);
  }
}
