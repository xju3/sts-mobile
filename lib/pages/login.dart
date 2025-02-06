import 'package:jiwa/mixins/login_minxin.dart';
import 'package:jiwa/server/api/account_api.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  final _formKey = GlobalKey<FormState>();
  final _accountApi = AccountApi();
  String? _mobile;

  void _register() {
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
              ElevatedButton(
                onPressed: _register,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
