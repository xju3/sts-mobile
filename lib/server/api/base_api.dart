
import 'package:dio/dio.dart';
import 'package:jiwa/server/api/dio_interceptors.dart';
import 'package:logger/logger.dart';


final dio = Dio();

Logger logger = Logger(printer: PrettyPrinter());

Dio getDio() {
  if (dio.interceptors.length == 1) {
    dio.interceptors.add(AppInterceptors());
  }
  return dio;
}

abstract class BaseApi {



}