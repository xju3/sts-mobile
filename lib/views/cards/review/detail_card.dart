import 'package:flutter/material.dart';
import 'package:duowoo/server/model/review_detail.dart';

class ReviewDetailCard extends StatelessWidget {
  final ReviewDetail detail;

  const ReviewDetailCard(this.detail,{ Key? key,
  }) : super(key: key);

  // 根据conclusion获取卡片颜色
  Color _getCardColor(int? conclusion) {
    switch (conclusion) {
      case 1:
        return Color(0xFFE8F5E9); // 浅绿色表示正确
      case -1:
        return Color(0xFFFFEBEE); // 浅红色表示错误
      case 0:
        return Color(0xFFF5F5F5); // 浅灰色表示未作答
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = detail.conclusion == 1;

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),
      color: _getCardColor(detail.conclusion),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 题号
            Text(
              '第${detail.no}题',
              style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Divider(height: 24),

            // 学生答案
            _buildSection(
              '你的答案:',
              detail.ansStudent ?? '未作答',
              detail.conclusion != 1 ? Colors.grey : Colors.green,
            ),

            // 正确答案
            _buildSection('正确答案:', detail.ansAi ?? '', Colors.green),
            // 解题方法
            _buildSection('解题方法:', detail.solution ?? ''),
            // 如果答案错误，显示原因分析
            if (!isCorrect && detail.reason != null)
              _buildSection('错误分析:', detail.reason!),

            // 知识点标签
            if (detail.knowledge != null && detail.knowledge!.isNotEmpty)
              _buildKnowledgeTags(detail.knowledge!),

            // 如果答案错误，显示学习建议
            if (!isCorrect && detail.suggestion != null)
              _buildSection('学习建议:', detail.suggestion!),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, [Color? contentColor]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:TextStyle(  fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,),
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(  fontSize: 15,
              color: contentColor ?? Colors.black87,
              height: 1.5,),
          ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeTags(String knowledge) {
    // 将知识点字符串分割成列表
    final tags = knowledge.split(RegExp(r'[,\s]+')).where((tag) => tag.isNotEmpty).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '相关知识点:',
            style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) => _buildTag(tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
        ),
      ),
      child: Text(
        tag,
        style:TextStyle(
          fontSize: 14,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }
}