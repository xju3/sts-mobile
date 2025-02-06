import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiwa/server/model/review_ai.dart';
import 'package:jiwa/server/model/review_detail.dart';

class AIReviewCard extends StatelessWidget {
  final ReviewAi review;
  final Function(List<ReviewDetail>) showReviewDetails;
  const AIReviewCard(this.review, this.showReviewDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Review Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Submission Time: ${formatter.format(review.transTime!)}'),
                Text(
                    'Review Duration: ${_calculateDuration(review.startTime!, review.endTime!)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Review Start Time: ${formatter.format(review.startTime!)}'),
                Text('Review End Time: ${formatter.format(review.endTime!)}'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Questions: $review.total'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Correct: $review.correct'),
                    Text('Wrong: $review.incorrect', ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Summary:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(review.summary!),
          ],
        ),
      ),
    );
  }

  String _calculateDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    return duration.inMinutes.toString() + ' minutes';
  }
}
