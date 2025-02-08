import 'package:duowoo/views/mixins/common_mixin.dart';
import 'package:duowoo/views/pages/review/detail.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:duowoo/views/mixins/image_picker_mixin.dart';
import 'package:duowoo/views/mixins/home_mixin.dart';
import 'package:duowoo/server/api/review_api.dart';
import 'package:duowoo/views/cards/review/review_info.dart';

import '../../../server/model/review_ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ImagePickerMixin, HomeMixin, StringMixin {
  var logger = Logger(printer: PrettyPrinter());
  final reviewApi = ReviewApi();
  void handleImageSelection(BuildContext context, AssetEntity asset) {
    //logger.d(asset.size);
  }
  List<ReviewAi> reviews = [];
  @override
  void initState() {
    super.initState();
    logger.d(widget.title);
    getReviewList().then((value) {
      reviews = value;
      setState(() { });
    });
  }

  void selectImages() async {
    List<AssetEntity>? assets = await openPicker(context, 9, handleImageSelection);
    if (assets == null) return;
    uploadAssignments(assets, minioUpload);
  }

  void showReviewDetail(ReviewAi review, int conclusion, int total) {
    if (total == 0) return;
    logger.d('conclusion: $conclusion, total: $total');
    var details = review.details?.where((x) => x.conclusion == conclusion).toList();
    if (details == null || details.isEmpty) {
      return;
    }
    Navigator.push(context, MaterialPageRoute( builder: (context) => ReviewDetailPage(getDateTime(review.transTime), details, conclusion) ));
  }
  // void showReviewDetail(List<ReviewDetail> details) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body:ListView(
          children:
              reviews.map((e) => ReviewCard(e, showReviewDetail)).toList(),
        ),
        floatingActionButton: FloatingActionButton(onPressed: selectImages));
  }
}
