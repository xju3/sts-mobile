import 'package:flutter/material.dart';

class DraggableButtonWidget extends StatefulWidget {
  final VoidCallback onTap; // 添加点击回调函数参数
  final String buttonText; // 添加按钮文字参数
  final Offset initialPosition; // 添加初始位置参数

  const DraggableButtonWidget({
    Key? key,
    required this.onTap,
    this.buttonText = '可拖动的按钮',
    this.initialPosition = const Offset(100, 100),
  }) : super(key: key);

  @override
  State<DraggableButtonWidget> createState() => _DraggableButtonWidgetState();
}

class _DraggableButtonWidgetState extends State<DraggableButtonWidget> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  position = Offset(
                    position.dx + details.delta.dx,
                    position.dy + details.delta.dy,
                  );
                });
              },
              child: ElevatedButton(
                onPressed: widget.onTap,
                child: Text(widget.buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}