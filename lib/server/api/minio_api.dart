import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:jiwa/server/api/constants.dart';
import 'package:jiwa/server/api/base_api.dart';

part 'minio_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class MinioApi extends BaseApi {
  factory MinioApi() {
    return _MinioApi(getDio());
  }

  @GET("/minio/get_access_key")
  Future<String> getPreassignedPutKey(@Path('objectName') String objectName);

  @PUT("{url}")
  @MultiPart()
  Future<void> Upload(@Path("url") String url, @Header("Content-Type") header,
      @Part() File file);
}
