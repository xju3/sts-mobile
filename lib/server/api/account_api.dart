import 'package:dio/dio.dart';
import 'package:duowoo/server/model/account.dart';
import 'package:retrofit/retrofit.dart';
import 'package:duowoo/server/model/registration.dart';

import 'package:duowoo/server/api/constants.dart';
import 'base_api.dart';

part 'account_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class AccountApi extends BaseApi {
  factory AccountApi() {
    return _AccountApi(getDio());
  }

  @POST("/account/login")
  Future<AccountInfo> login(@Field("mobile") mobile);

  @POST("/account/create")
  Future<AccountInfo> create(@Body() Registration registration);
}
