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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(widget.date, [], false),
        drawer: CustomDraw(),
        body: ListView(
            children: widget.details.map((e) => ReviewDetailCard(e)).toList()));
  }
}
