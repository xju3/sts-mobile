import 'package:dio/dio.dart';
import 'package:duowa/server/model/review_ai.dart';
import 'package:retrofit/retrofit.dart';
import 'package:duowa/server/api/base_api.dart';

import 'package:duowa/server/api/constants.dart';

part 'review_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class ReviewApi extends BaseApi {
  factory ReviewApi() {
    return _ReviewApi(getDio());
  }

  @PUT("/review/ai/list/{studentId}")
  Future<List<ReviewAi>> getReviewList(@Path() String studentId);

  @PUT("/review/request/create/{studentId}/{requestId}")
  Future<void> createReview(
      @Path() String studentId, @Path() String requestId);

  @PUT("/review/request/create/{requestId}/{conclusion}")
  Future<void> getReviewDetails(@Path() String requestId, @Path() String conclusion);

}
