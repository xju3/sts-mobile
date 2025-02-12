import 'package:dio/dio.dart';
import 'package:duowoo/server/model/account.dart';
import 'package:duowoo/server/model/login_history.dart';
import 'package:duowoo/server/model/school.dart';
import 'package:retrofit/retrofit.dart';
import 'package:duowoo/server/model/registration.dart';

import 'package:duowoo/server/api/constants.dart';
import 'package:duowoo/server/model/login.dart';
import 'base_api.dart';

part 'account_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class AccountApi extends BaseApi {
  factory AccountApi() {
    return _AccountApi(getDio());
  }

  @POST("/account/login")
  Future<AccountInfo> login(@Body() Login login);

  @POST("/account/login/history")
  Future<void> createLoginHistory(@Body() LoginHistory history);

  @POST("/account/create")
  Future<AccountInfo> create(@Body() Registration registration);

  @PUT("/account/schools/{lat}/{lng}")
  Future<List<School>> getSchools(@Path() double lat, @Path() double lng);
}
