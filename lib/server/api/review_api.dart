import 'package:dio/dio.dart';
import 'package:jiwa/server/model/review_ai.dart';
import 'package:retrofit/retrofit.dart';
import 'package:jiwa/server/api/base_api.dart';

import 'package:jiwa/server/api/constants.dart';

part 'review_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class ReviewApi extends BaseApi {
  factory ReviewApi() {
    return _ReviewApi(getDio());
  }

  @POST("/review/ai/list/{studentId}")
  Future<List<ReviewAi>> getReviewList(@Path() String studentId);

  @POST("/review/request/create/{studentId}/{requestId}")
  Future<List<ReviewAi>> createReview(
      @Path() String studentId, @Path() String requestId);
}
