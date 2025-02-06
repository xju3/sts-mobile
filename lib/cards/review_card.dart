import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AIReviewCard extends StatelessWidget {
  final DateTime submissionTime;
  final DateTime aiReviewStartTime;
  final DateTime aiReviewEndTime;
  final int totalQuestions;
  final int wrongAnswers;
  final int correctAnswers;
  final String summary;

  const AIReviewCard({
    Key? key,
    required this.submissionTime,
    required this.aiReviewStartTime,
    required this.aiReviewEndTime,
    required this.totalQuestions,
    required this.wrongAnswers,
    required this.correctAnswers,
    required this.summary,
  }) : super(key: key);

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
                Text('Submission Time: ${formatter.format(submissionTime)}'),
                Text('Review Duration: ${_calculateDuration(aiReviewStartTime, aiReviewEndTime)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Review Start Time: ${formatter.format(aiReviewStartTime)}'),
                Text('Review End Time: ${formatter.format(aiReviewEndTime)}'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Questions: $totalQuestions'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Correct: $correctAnswers'),
                    Text('Wrong: $wrongAnswers'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Summary:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(summary),
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
