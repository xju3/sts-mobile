import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duowoo/views/mixins/common_mixin.dart';
import 'package:duowoo/views/mixins/message_mixin.dart';
import 'package:duowoo/views/pages/review/images.dart';
import 'package:duowoo/views/pages/review/detail.dart';
import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:duowoo/views/pages/common/base.dart';
import 'package:duowoo/views/widgets/menu_draw.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:duowoo/views/mixins/image_picker_mixin.dart';
import 'package:duowoo/views/mixins/review_mixin.dart';
import 'package:duowoo/server/api/review_api.dart';
import 'package:duowoo/views/cards/review/review_info.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:empty_widget_pro/empty_widget_pro.dart';

import '../../../server/model/review_ai.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends BasePage<ReviewPage>
    with ImagePickerMixin, ReviewMixin, StringMixin, MessageMixin, CommonMixin {
  var logger = Logger(printer: PrettyPrinter());
  final reviewApi = ReviewApi();
  DateTime curr = DateTime.now();
  DateTime today = DateTime.now();
  bool loaded = false;

  void handleImageSelection(BuildContext context, AssetEntity asset) {
    //logger.d(asset.size);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    EasyLoading.show(status: "正在查询数据");
    await mxGetReviewList(mxGetDateTime(curr)).then((value) {
      setState(() {
        reviews = value;
        EasyLoading.dismiss();
      });
    });
    _refreshController.refreshCompleted();
  }

  Future _showImagePage(String? requestId) async {
    if (requestId == null) return;
    var images = await reviewApi.getReviewImages(requestId);
    if (images.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImagesPage(
                imageUrls: images,
                initialIndex: 0,
              )),
    );
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
    _onRefresh();
  }

  void showSnackbar() {
    mxShowSnackbar("AI正在批改本次作业，此过程大约需要1～2分钟，任务完成后，您会收到系统通知.",
        ContentType.success, context);
  }

  void selectImages() async {
    List<AssetEntity>? assets =
        await mxOpenPicker(context, 9, handleImageSelection);
    if (assets == null) return;
    mxUploadAssignments(assets, mxMinioUpload, showSnackbar).then((val) {});
  }

  void changeDate() {
    showDatePicker(
      context: context,
      firstDate: today.subtract(const Duration(days: 31)),
      lastDate: today,
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          curr = selectedDate;
          _onRefresh();
        });
      }
    });
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
                mxGetDateTime(review.transTime), details, conclusion)));
  }

  List<Widget> getActions() {
    return [
      IconButton(
          onPressed: changeDate,
          icon: Icon(
            FluentIcons.calendar_24_regular,
            color: Colors.teal,
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(mxGetDateTime(curr), getActions(), true),
      drawer: CustomDraw(),
      // backgroundColor: Color(0XFFBFBBA9),
      floatingActionButton: IconButton(
          onPressed: this.selectImages,
          icon: Icon(
            FluentIcons.add_48_filled,
            color: Colors.white,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.purple),
          )),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children: reviews.isEmpty && loaded
              ? [
                  Center(
                      child: EmptyWidget(
                    title: "${mxGetDateTime(curr)}无作业上传",
                    titleTextStyle: TextStyle(
                      fontSize: 22,
                      color: Color(0xff9da9c7),
                      fontWeight: FontWeight.w500,
                    ),
                    subtitleTextStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xffabb8d6),
                    ),
                  ))
                ]
              : reviews
                  .map((e) => ReviewCard(e, showReviewDetail, _showImagePage))
                  .toList(),
        ),
      ),
    );
  }
}
