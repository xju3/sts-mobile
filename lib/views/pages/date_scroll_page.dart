import 'package:flutter/material.dart';
import 'package:jiwa/views/widgets/draggable_button.dart';
import 'package:intl/intl.dart';

class DateScrollPage extends StatefulWidget {
  const DateScrollPage({super.key});

  @override
  State<DateScrollPage> createState() => _DateScrollPageState();
}

class _DateScrollPageState extends State<DateScrollPage> {
  late DateTime _selectedDate;
  final DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = _today;
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _onSwipeLeft() {
    setState(() {
      // 向左滑动，日期减一天
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _onSwipeRight() {
    // 检查是否可以向右滑动（不能超过今天）
    final nextDate = _selectedDate.add(const Duration(days: 1));
    if (!nextDate.isAfter(_today)) {
      setState(() {
        _selectedDate = nextDate;
      });
    } else {
      // 提示用户已经到达今天
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('不能选择将来的日期')),
      );
    }
  }

  void _onDateSelected(DateTime? picked) {
    if (picked == null) return;

    // 验证选择的日期不能超过今天
    if (picked.isAfter(_today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('不能选择将来的日期')),
      );
      return;
    }

    setState(() {
      _selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatDate(_selectedDate),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: _today.subtract(const Duration(days: 365)),
                lastDate: _today,
              );
              _onDateSelected(picked);
            },
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity == null) return;

          // 检测滑动方向
          if (details.primaryVelocity! > 0) {
            // 向右滑动
            _onSwipeRight();
          } else if (details.primaryVelocity! < 0) {
            // 向左滑动
            _onSwipeLeft();
          }
        },
        child: Stack(
          children: [
            // 页面主体内容
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '当前日期: ${_formatDate(_selectedDate)}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  // 添加左右滑动提示
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_left),
                      Text('左右滑动切换日期'),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DraggableButtonWidget(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Clicked on ${_formatDate(_selectedDate)}'),
                        ),
                      );
                    },
                    buttonText: '拖动我',
                    initialPosition: const Offset(100, 300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
