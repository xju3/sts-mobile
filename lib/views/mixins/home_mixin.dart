import 'package:flutter/material.dart';
import 'package:duowoo/server/model/review_ai.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:duowoo/server/api/review_api.dart';

final uuid = const Uuid();
final reviewApi = ReviewApi();
final logger = Logger(printer: PrettyPrinter());

mixin HomeMixin<T extends StatefulWidget> {
  //
  Future<void> mxUploadAssignments(
      List<AssetEntity> assets,
      Function(List<AssetEntity>, String, Function(int, bool)) uploader,
      Function popupMessage) async {
    EasyLoading.dismiss();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');
    if (studentId == null) {
      return;
    }
    var requestId = uuid.v1();
    var resourceId = '$studentId/$requestId';

    int count = assets.length;

    Future<void> onSuccess(int index, bool val) async {
      EasyLoading.show(status: "已上传: $index / $count.");
      if (!val) {
        logger.e("image uploaded failed: $index of $count");
      }
      if (index == count) {
        EasyLoading.show(status: "作业上传完成,正在向AI发送批改请求.");
        logger.i("create review request: $requestId of $studentId");
        await reviewApi.createReview(studentId, requestId);
        EasyLoading.dismiss();
        popupMessage();
        index++;
      }
    }

    // EasyLoading.show(status: "正在上传文件...");
    uploader(assets, resourceId, onSuccess);
    // EasyLoading.dismiss();
  }

  Future<List<ReviewAi>> mxGetReviewList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');
    return reviewApi.getReviewList(studentId!);
  }
}
