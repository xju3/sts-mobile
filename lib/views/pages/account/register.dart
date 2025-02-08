import 'package:flutter/material.dart';
import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/server/model/registration.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with LoginMixin {
  final _formKey = GlobalKey<FormState>();
  final _registration = Registration();
  final _accountApi = AccountApi();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _accountApi.create(_registration).then((accountInfo) async {
        loginHandler(
            "Registration successful!", _accountApi, accountInfo, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your student name';
                  }
                  return null;
                },
                onSaved: (value) => _registration.student = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'School Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student\'s school name';
                  }
                  return null;
                },
                onSaved: (value) => _registration.school = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Grade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student\'s grade';
                  }
                  return null;
                },
                onSaved: (value) => _registration.grade = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _registration.mobile = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Your Name'),
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _registration.parent = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
