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
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with LoginMixin, MessageMixin {
  final _formKey = GlobalKey<FormState>();
  final _accountApi = AccountApi();
  final logger = Logger(printer: PrettyPrinter());
  List<School> schools = [];

  void _submit(Registration registration)  async{
    _accountApi.create(registration).then((accountInfo)  {
      mxLoginHandler(_accountApi, accountInfo, context, null);
    });
  }

  Future<void> _findSchools() async {
    EasyLoading.show(status: "正在检查本设备是否开启位置服务");
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // final hasPermission = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      try {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting the permission again (this is also where
          // Android's shouldShowRequestPermissionRationale returned true.
          return Future.error(
              'Location permissions are denied, we cannot request permissions.');
        }
      } catch (e) {
        return Future.error(e);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    EasyLoading.show(status: "正在获取你当前位置，以查找周边的学校");
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    EasyLoading.show(status: "正在准备学校数据.");
    var data = await _accountApi.getSchools(position.latitude, position.longitude);
    setState(() {
      logger.d("schools : ${data.length}");
      schools = data;
    });

    if (data.isEmpty) {
      mxShowSnackbar("周边没有找学校，建议你到学校近的地方居住，方便孩子上学", ContentType.failure, context);
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
