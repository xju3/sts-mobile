import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/school.dart';
import 'package:duowoo/server/model/student.dart';
import 'package:duowoo/views/forms/student.dart';
import 'package:duowoo/views/mixins/location_minxin.dart';
import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/views/mixins/message_mixin.dart';
import 'package:duowoo/views/pages/common/base.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends BasePage<StudentPage>
    with MessageMixin, LoginMixin, LocationMixin {
  final _formKey = GlobalKey<FormState>();
  final accountApi = AccountApi();
  final student = Student();
  final logger = Logger(printer: PrettyPrinter());
  List<School> schools = [];

  @override
  void initState() {
    super.initState();
    getSchoolsAround();
  }


  void getSchoolsAround() async {
    EasyLoading.show(status: "正在查找周边的学校");
    var data = await findSchool(accountApi);
    setState(() {
      schools = data;
    });
    EasyLoading.dismiss();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var accountInfo = await getAccountInfo();
      var accountId = accountInfo?.parent?.accountId;
      if (null == accountId) return;
      accountApi.addStudent(accountId, student).then((val) {
        if (!mounted) return;
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学生登记'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              submit();
            },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StudentForm(student, _formKey, schools)),
    );
  }
}
