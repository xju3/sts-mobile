import 'package:dio/dio.dart';
import 'package:jiwa/mixins/common_mixin.dart';
import 'package:jiwa/server/api/constants.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor with MessageMixin {
  final Logger logger = Logger(printer: PrettyPrinter());

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.kToken);
    if (null != token) {
      options.headers.addAll({"Authorization": 'Bearer $token', 'ngrok-skip-browser-warning':'hello'});
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
    if (response.statusCode != 200) {
      logger.e("response status: ${response.statusCode}");
      return;
    }

    if (response.data.length == 0) {
      logger.i("empty value.");
      return;
    }

    // 修改过返回值的内容，若是list直接返回
    if (response.data is List) {
      handler.next(response);
      return;
    }
  }
}
