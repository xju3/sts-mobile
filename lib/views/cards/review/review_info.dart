import 'package:flutter/material.dart';
import 'package:duowa/server/model/review_ai.dart';

final Map<String, Color> subjectColors = {
  '语文': Color(0xFFF0F0F0),
  '数学': Color(0xFFFFF9C4),
  '英语': Color(0xFFE3F2FD),
  '科学': Color(0xFFF1F8E9),
  '其他': Color(0xFFFFF3E0)
};

class ReviewCard extends StatelessWidget {
  final ReviewAi review;
  final Function(ReviewAi, int, int) showReviewDetails;

  const ReviewCard(
    this.review,
    this.showReviewDetails, {
    Key? key,
  }) : super(key: key);


  void onCorrectButtonTapped(){
    showReviewDetails(review, 1, review.correct ?? 0);
  }
  void onInCorrectButtonTapped(){
    showReviewDetails(review, -1, review.incorrect ?? 0);
  }
  void onUncertainButtonTapped(){
    showReviewDetails(review, 0, review.uncertain?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final color = subjectColors[review.subject] ?? subjectColors['其他']!;

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.subject ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    _buildStatChip('正确', review.correct ?? 0, Colors.green, onCorrectButtonTapped),
                    SizedBox(width: 8),
                    _buildStatChip('错误', review.incorrect ?? 0, Colors.red, onInCorrectButtonTapped),
                    SizedBox(width: 8),
                    _buildStatChip('未答', review.uncertain ?? 0, Colors.grey, onUncertainButtonTapped),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 150,
                minHeight: 50,
              ),
              child: SingleChildScrollView(
                child: Text(
                  review.summary ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            _buildTimeFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, int value, Color color, VoidCallback? onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$label: $value',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFooter() {
    final duration = review.endTime?.difference(review.startTime!);
    final minutes = duration?.inMinutes;
    int? inSeconds = duration?.inSeconds;
    int seconds = 0;
    if (inSeconds != null) {
      seconds = inSeconds % 60;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '完成时间: ${review.transTime?.year}-${review.transTime?.month}-${review.transTime?.day} '
          '${review.transTime?.hour}:${review.transTime?.minute}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        Text(
          'AI用时: $minutes分$seconds秒',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
