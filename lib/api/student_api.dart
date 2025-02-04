import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:jiwa/api/model/ticket.dart';

import 'package:jiwa/api/constants.dart';
import 'base_api.dart';

part 'student_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class StudentApi extends BaseApi {

  factory StudentApi() {
    return _StudentApi(getDio());
  }

  @POST("/images/upload")
  @MultiPart()
  Future<Ticket> uploadImages(@Part() String studentId, @Part() List<MultipartFile>? files,);
  
}
