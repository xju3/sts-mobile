import 'dart:math';

import 'package:duowoo/server/model/school.dart';
import 'package:duowoo/views/mixins/text_style_mixin.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/server/model/registration.dart';
import 'package:logger/logger.dart';
import 'package:select_dialog/select_dialog.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(Registration) onSubmit;
  final Function findSchools;
  final List<School> schools;

  const RegisterForm(
    this.formKey,
    this.onSubmit,
    this.schools,
    this.findSchools, {
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with TextStyleMixin {
  School? selectedSchool = null;
  final _schoolController = TextEditingController();
  Registration registration = Registration();
  final logger = Logger(printer: PrettyPrinter());

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  TextStyle registerFormTextStyle() {
    return textstyleSma();
  }

  void onSchoolSelected(School school) {
    setState(() {
      registration.schoolId = school.id;
      registration.school = school.fullName;
      _schoolController.text = registration.school ?? "";
    });
  }

  void register() {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      widget.onSubmit(registration);
    }
  }

  void selectSchool(List<School> schools) async {
    logger.d("schools: ${schools.length}");
    if (widget.schools.isEmpty) {
      widget.findSchools();
      return;
    }

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
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
            onSaved: (value) => registration.school = value,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Student Name', labelStyle: registerFormTextStyle()),
            validator: (value) => _validateField(value, "学生姓名"),
            onSaved: (value) => registration.student = value,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Grade', labelStyle: registerFormTextStyle()),
            validator: (value) => _validateField(value, "年级"),
            onSaved: (value) => registration.grade = value,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Account Name', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validateField(value, "登录账户"),
            onSaved: (value) => registration.mobile = value,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Your Name', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.text,
            validator: (value) => _validateField(value, "您的称呼"),
            onSaved: (value) => registration.parent = value,
          ),
          ElevatedButton(
            onPressed: register,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
