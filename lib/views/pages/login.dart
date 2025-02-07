import 'package:duowa/views/mixins/login_minxin.dart';
import 'package:duowa/server/api/account_api.dart';
import 'package:flutter/material.dart';
import 'package:duowa/views/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  final _formKey = GlobalKey<FormState>();
  final _accountApi = AccountApi();
  String? _mobile = '18301880898';

  void _register() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _accountApi.login(_mobile).then((accountInfo) async {
        loginHandler("login successfully", _accountApi, accountInfo, context);
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                initialValue: '18301880898',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _mobile = value,
              ),
              const SizedBox(height: 20),
              Row(children: [
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('注册'),
                ),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
