import 'package:duowa/server/model/review_detail.dart';
import 'package:duowa/views/cards/review/detail_card.dart';
import 'package:flutter/material.dart';

class ReviewDetailPage extends StatefulWidget {
  final List<ReviewDetail> details;

  const ReviewDetailPage(this.details, {Key? key}) : super(key: key);

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(""),
        ),
        body: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              crossAxisCount: 1,
            ),
            children: widget.details.map((e) => ReviewDetailCard(e)).toList()));
  }
}
