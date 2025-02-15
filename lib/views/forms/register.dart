import 'package:duowoo/server/model/school.dart';
import 'package:duowoo/views/mixins/text_style_mixin.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/server/model/registration.dart';
import 'package:logger/logger.dart';
import 'package:select_dialog/select_dialog.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Registration registration;
  final List<School> schools;

  const RegisterForm(
    this.formKey,
    this.registration,
    this.schools, {
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with TextStyleMixin {
  School? selectedSchool;
  final _schoolController = TextEditingController();
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
      widget.registration.schoolId = school.id;
      widget.registration.schoolName = school.fullName;
      _schoolController.text = widget.registration.schoolName ?? "";
    });
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
          title: Text(option.fullName ?? ""),
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
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: '登录账号', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validateField(value, "登录账户"),
            onSaved: (value) => widget.registration.account = value,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                labelText: '您的称呼', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.text,
            validator: (value) => _validateField(value, "您的称呼"),
            onSaved: (value) => widget.registration.parent = value,
          ),
          TextFormField(
            controller: _schoolController,
            readOnly: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: '学校名称',
              labelStyle: registerFormTextStyle(),
              suffixIcon: IconButton(
                onPressed: () => selectSchool(widget.schools),
                icon: Icon(Icons.search),
              ),
            ),
            validator: (value) => _validateField(value, "学校名称"),
            onSaved: (value) => widget.registration.schoolName = value,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: '学生称呼', labelStyle: registerFormTextStyle()),
            validator: (value) => _validateField(value, "学生姓名"),
            onSaved: (value) => widget.registration.student = value,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: '年级', labelStyle: registerFormTextStyle()),
            validator: (value) => _validateField(value, "年级"),
            onSaved: (value) => widget.registration.grade = value,
          ),
        ],
      ),
    );
  }
}
