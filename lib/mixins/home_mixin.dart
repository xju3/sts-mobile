import 'package:flutter/material.dart';
import 'package:jiwa/server/model/review_ai.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:jiwa/server/api/review_api.dart';

final uuid = const Uuid();
final reviewApi = ReviewApi();

mixin HomeMixin<T extends StatefulWidget> {
  void uploadAssignments(List<AssetEntity> assets,
      Function(List<AssetEntity>, String, Function(int)) uploader) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');
    if (studentId == null) {
      return;
    }
    var requestId = uuid.v1();
    var resourceId = '$studentId/$requestId';

    int count = assets.length;

    Future<void> onSuccess(index) async {
      EasyLoading.show(status: "正在上传文件($index/$count)");
      if (index == count) {
        await reviewApi.createReview(studentId, requestId);
        FBroadcast.instance().broadcast("review_submit",
            value: '您的作业已提交，AI正在检查您的作业，此过程大约需要1分钟,请耐心等待.');
      }
    }

    EasyLoading.show(status: "正在上传文件...");
    uploader(assets, resourceId, onSuccess);
    EasyLoading.dismiss();
  }

  Future<List<ReviewAi>> getReviewList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');
    return reviewApi.getReviewList(studentId!);
  }
}
