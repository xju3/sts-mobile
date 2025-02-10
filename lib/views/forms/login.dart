import 'package:duowoo/server/model/login.dart';
import 'package:duowoo/views/mixins/text_style_mixin.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget with TextStyleMixin {
  final GlobalKey<FormState> formKey;
  final Login login;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback onRegister;
  final VoidCallback onLogin;

  const LoginForm({
    Key? key,
    required this.formKey,
    required this.onRegister,
    required this.onLogin,
    required this.login,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            initialValue: login.account,
            decoration: InputDecoration(
                labelText: 'Account Name', labelStyle: textstyleSma()),
            validator: (value) => _validateField(value, ""),
            onSaved: (value) => login.account = value,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: onRegister,
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: onLogin,
                child: const Text('Login'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
