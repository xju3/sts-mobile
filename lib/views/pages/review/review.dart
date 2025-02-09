import 'package:duowoo/views/mixins/common_mixin.dart';
import 'package:duowoo/views/pages/review/detail.dart';
import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:duowoo/views/widgets/menu_draw.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:duowoo/views/mixins/image_picker_mixin.dart';
import 'package:duowoo/views/mixins/home_mixin.dart';
import 'package:duowoo/server/api/review_api.dart';
import 'package:duowoo/views/cards/review/review_info.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../server/model/review_ai.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage>
    with ImagePickerMixin, HomeMixin, StringMixin {
  var logger = Logger(printer: PrettyPrinter());
  final reviewApi = ReviewApi();

  void handleImageSelection(BuildContext context, AssetEntity asset) {
    //logger.d(asset.size);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await getReviewList().then((value) {
      reviews = value;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  List<ReviewAi> reviews = [];

  @override
  void initState() {
    super.initState();
    getReviewList().then((value) {
      reviews = value;
      setState(() {});
    });
  }

  void selectImages() async {
    List<AssetEntity>? assets =
        await openPicker(context, 9, handleImageSelection);
    if (assets == null) return;
    await uploadAssignments(assets, minioUpload);
  }

  void showReviewDetail(ReviewAi review, int conclusion, int total) {
    if (total == 0) return;
    logger.d('conclusion: $conclusion, total: $total');
    var details =
        review.details?.where((x) => x.conclusion == conclusion).toList();
    if (details == null || details.isEmpty) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewDetailPage(
                getDateTime(review.transTime), details, conclusion)));
  }

  List<Widget> getActions() {
    return [
      IconButton(
          onPressed: selectImages,
          icon: Icon(
            FluentIcons.book_48_regular,
            color: Colors.teal,
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("作业", getActions()),
      drawer: CustomDraw(),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children:
              reviews.map((e) => ReviewCard(e, showReviewDetail)).toList(),
        ),
      ),
    );
  }
}
