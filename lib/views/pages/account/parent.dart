import 'package:duowoo/server/api/account_api.dart';
import 'package:duowoo/views/mixins/login_minxin.dart';
import 'package:flutter/material.dart';
import 'package:duowoo/views/forms/parent.dart';
import 'package:duowoo/server/model/parent.dart';

class ParentAccountPage extends StatefulWidget {
  const ParentAccountPage({super.key});

  @override
  State<ParentAccountPage> createState() => _ParentAccountPageState();
}

class _ParentAccountPageState extends State<ParentAccountPage> with LoginMixin {
  final _formKey = GlobalKey<FormState>();
  final Parent parent = Parent();
  final accountApi = AccountApi();

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var accountInfo = await getAccountInfo();
      var accountId = accountInfo?.parent?.accountId;
      if (null == accountId) return;
      accountApi.addParent(accountId, parent).then((val) {
        if (!mounted) return;
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家长登记'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            submit();
          },
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ParentForm(parent, _formKey),
      ),
    );
  }
}
