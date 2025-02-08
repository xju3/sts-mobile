import 'package:duowoo/server/model/review_detail.dart';
import 'package:duowoo/views/cards/review/detail_card.dart';
import 'package:flutter/material.dart';

class ReviewDetailPage extends StatefulWidget {
  final String date;
  final List<ReviewDetail> details;
  final int type;

  const ReviewDetailPage(this.date, this.details, this.type, {Key? key}) : super(key: key);

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.date),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:ListView(
            children: widget.details.map((e) => ReviewDetailCard(e)).toList()));
  }
}
