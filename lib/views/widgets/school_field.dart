import 'package:duowoo/server/model/school.dart';
import 'package:flutter/material.dart';

class SchoolFormField extends StatefulWidget {
  final List<School> schools;
  final Function findSchools;

  SchoolFormField(this.schools, this.findSchools, {Key? key}) : super(key: key);

  @override
  _SchoolFormFieldState createState() => _SchoolFormFieldState();
}

class _SchoolFormFieldState extends State<SchoolFormField> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      decoration: InputDecoration(
        labelText: '学校名称',
        suffixIcon: IconButton(
          onPressed: widget.findSchools(),
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
