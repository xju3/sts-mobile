import 'package:duowoo/server/api/review_api.dart';
import 'package:duowoo/server/model/review_detail.dart';
import 'package:duowoo/views/cards/review/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:duowoo/views/widgets/menu_draw.dart';
import 'package:duowoo/views/pages/common/base.dart';

class ReviewDetailPage extends StatefulWidget {
  final String date;
  final List<ReviewDetail> details;
  final int type;

  const ReviewDetailPage(this.date, this.details, this.type, {Key? key})
      : super(key: key);

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends BasePage<ReviewDetailPage> {

  final reviewApi = ReviewApi();

  void findErr(ReviewDetail detail) async {
    if (detail.err == 1) return;
    reviewApi.setAiReviewErr(detail.id!).then((onValue) {
      setState(() {
        detail.err = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFFDFD3C3),
          title: const Text('解题详情', style: TextStyle(color:  Colors.teal),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        drawer: CustomDraw(),
        body: ListView(
            children: widget.details.map((e) => ReviewDetailCard(e, findErr)).toList()));
  }
}
