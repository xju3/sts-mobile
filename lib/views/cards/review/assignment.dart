import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:duowoo/server/model/assignment.dart';

class AssignmentCard extends StatefulWidget {
  final Assignment assignment;

  const AssignmentCard({Key? key, required this.assignment}) : super(key: key);

  @override
  _AssignmentCardState createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.assignment.subject ?? '未指定学科'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.assignment.yearId ?? '未知年份'} / ${widget.assignment.weekId ?? '未知周'}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('总数: ${widget.assignment.total ?? 0}'),
                Text('简单: ${widget.assignment.easy ?? 0}'),
                Text('中等: ${widget.assignment.medium ?? 0}'),
                Text('困难: ${widget.assignment.hard ?? 0}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '生成时间: ${widget.assignment.id != null ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()) : '未知时间'}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '正确率: ${widget.assignment.correct != null && widget.assignment.total != null ? (widget.assignment.correct! / widget.assignment.total! * 100).toStringAsFixed(1) : '0'}%',
                  style: const TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
