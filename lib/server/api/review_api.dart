import 'package:dio/dio.dart';
import 'package:duowoo/server/model/review_ai.dart';
import 'package:duowoo/server/model/review_request.dart';
import 'package:retrofit/retrofit.dart';
import 'package:duowoo/server/api/base_api.dart';
import 'package:duowoo/server/api/constants.dart';

part 'review_api.g.dart';

@RestApi(baseUrl: AppConstants.kBaseUrl)
abstract class ReviewApi extends BaseApi {
  factory ReviewApi() {
    return _ReviewApi(getDio());
  }

  @GET("/review/request/images/{requestId}")
  Future<List<String>> getReviewImages(@Path() String requestId);

  @PUT("/review/ai/list/{studentId}")
  Future<List<ReviewAi>> getReviewList(@Path() String studentId);

  @PUT("/review/request/create/{studentId}/{requestId}/{images}")
  Future<void> createReview(
      @Path() String studentId, @Path() String requestId, @Path() int images);

  @PUT("/review/request/create/{requestId}/{conclusion}")
  Future<void> getReviewDetails(
      @Path() String requestId, @Path() String conclusion);
}
