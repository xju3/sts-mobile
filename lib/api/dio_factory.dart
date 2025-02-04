import 'package:dio/dio.dart';
import 'package:jiwa/api/constants.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioFactory {
  static final Dio _dio = Dio();
  static final DioFactory _instance = DioFactory._internal();
  final logger = Logger(printer: PrettyPrinter());

  Future<String?> getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstants.kToken);
  }

  factory DioFactory() {
    return _instance;
  }

  Dio dio() {
    return _dio;
  }

  DioFactory._internal() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      getUserToken().then((token) => {
            if (null != token)
              {logger.d(token), options.headers['Authorization'] = token}
          });
    }));

    _dio.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      logger.d(response);
    }));

    _dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {}));
  }
}
