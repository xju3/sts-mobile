import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duowoo/server/model/login.dart';
import 'package:duowoo/views/forms/login.dart';
import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/views/mixins/message_mixin.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/pages/account/register.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:duowoo/views/pages/common/base.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePage<LoginPage> with LoginMixin, MessageMixin {
  final _formKey = GlobalKey<FormState>();
  final JPush jPush = JPush();
  final _accountApi = AccountApi();
  final _login = Login();

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void onAccountNotFound() {
    mxShowSnackbar("账号不存在，请检查您输入的账号信息是否有误.", ContentType.failure, context);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _accountApi.login(_login).then((accountInfo) async {
        mxLoginHandler(
            jPush, _accountApi, accountInfo, context, onAccountNotFound);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(
            formKey: _formKey,
            onRegister: _register,
            onLogin: _submit,
            login: _login,
          )),
    );
  }
}