import 'package:flutter/material.dart';
import 'package:duowoo/server/model/school.dart';
import 'package:duowoo/server/model/student.dart';
import 'package:duowoo/views/mixins/text_style_mixin.dart';
import 'package:logger/logger.dart';
import 'package:select_dialog/select_dialog.dart';

class StudentForm extends StatefulWidget {
  final Student student;
  final GlobalKey<FormState> _formKey;
  final List<School> schools;

  const StudentForm(this.student, this._formKey, this.schools, {super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> with TextStyleMixin {
  School? selectedSchool;
  final logger = Logger(printer: PrettyPrinter());
  final _schoolController = TextEditingController();

  void onSchoolSelected(School school) {
    setState(() {
      widget.student.schoolId = school.id;
      widget.student.schoolName = school.fullName;
      _schoolController.text = school.fullName ?? "";
    });
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  TextStyle registerFormTextStyle() {
    return textstyleSma();
  }

  void selectSchool(List<School> schools) async {
    logger.d("schools: ${schools.length}");
    SelectDialog.showModal<School>(
      context,
      label: '请选择附近的学校',
      selectedValue: selectedSchool,
      items: List.generate(schools.length, (index) => schools[index]),
      itemBuilder: (BuildContext context, School option, bool isSelected) {
        return ListTile(
          titleTextStyle: TextStyle(
            color: Colors.deepOrange,
          ),
          selected: isSelected,
          title: Text(option.fullName ?? "999"),
        );
      },
      onChange: onSchoolSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _schoolController,
            readOnly: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'School Name',
              labelStyle: registerFormTextStyle(),
              suffixIcon: IconButton(
                onPressed: () => selectSchool(widget.schools),
                icon: Icon(Icons.search),
              ),
            ),
            validator: (value) => _validateField(value, "学校名称"),
            onSaved: (value) => widget.student.schoolName = value,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Student Name', labelStyle: registerFormTextStyle()),
            validator: (value) => _validateField(value, "学生姓名"),
            onSaved: (value) => widget.student.name = value,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Grade', labelStyle: registerFormTextStyle()),
            validator: (value) => _validateField(value, "年级"),
            onSaved: (value) =>
                widget.student.grade = int.tryParse(value ?? ''),
          ),
        ],
      ),
    );
  }
}
