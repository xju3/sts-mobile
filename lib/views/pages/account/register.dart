import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duowoo/server/model/school.dart';
import 'package:duowoo/views/forms/register.dart';
import 'package:duowoo/views/mixins/message_mixin.dart';
import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/registration.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:logger/logger.dart';
import 'package:duowoo/views/pages/common/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BasePage<RegisterPage> with LoginMixin, MessageMixin {
  final _formKey = GlobalKey<FormState>();
  final _accountApi = AccountApi();
  final JPush jPush = JPush();
  final logger = Logger(printer: PrettyPrinter());
  List<School> schools = [];

  void _submit(Registration registration)  async{
    _accountApi.create(registration).then((accountInfo)  {
      mxLoginHandler(jPush, _accountApi, accountInfo, context, null);
    });
  }

  Future<void> _findSchools() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "没开启位置服务");
      return;
    }
    // continue accessing the position of the device.
    EasyLoading.show(status: "正在获取你当前位置，以查找周边的学校");
    final position = await Geolocator.getLastKnownPosition();
    EasyLoading.show(status: "正在准备学校数据.");
    if (null == position) {
      //获取当前位置失败.
    }
    var latitude = position?.latitude?? 0.0;
    var longitude= position?.longitude?? 0.0;

    if (latitude > 0 || longitude > 0) {
      var data = await _accountApi.getSchools(latitude, longitude);
      if (data.isEmpty) {
        mxShowSnackbar("周边没有找学校，建议你到学校近的地方居住，方便孩子上学", ContentType.failure, context);
      } else {
        setState(() {
          logger.d("schools : ${data.length}");
          schools = data;
        });
      }
    }
    EasyLoading.dismiss();

  }



  @override
  void initState() {
    super.initState();
    this._findSchools();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("新用户注册", [], false) ,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                  "为了保护您与孩子的隐私，建议使用昵称注册;学校与年级，请认真填写，这会帮忙到AI更准确批改作业，产生巩固练习题目; 我们推荐您使用电子邮件作为账户名。欢迎您使用本产品!"),
              RegisterForm(
                _formKey,
                _submit,
                schools,
                _findSchools,
              )
            ],
          )),
    );
  }
}
