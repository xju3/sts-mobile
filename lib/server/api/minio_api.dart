import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:duowa/server/model/single_value.dart';
import 'package:retrofit/retrofit.dart';
import 'package:duowa/server/api/constants.dart';
import 'package:duowa/server/api/base_api.dart';

part 'minio_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class MinioApi extends BaseApi {
  factory MinioApi() {
    return _MinioApi(getDio());
  }

  @POST("/minio/get_access_key")
  Future<SingleValue> getPreassignedPutKey(@Field('objectName') String objectName);

}
