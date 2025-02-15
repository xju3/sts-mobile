import 'package:flutter/material.dart';
import 'package:duowoo/server/model/parent.dart';
import 'package:duowoo/views/mixins/text_style_mixin.dart';

class ParentForm extends StatefulWidget {
  final Parent parent;
  final GlobalKey<FormState> _formKey;
  const ParentForm(this.parent, this._formKey, {super.key});

  @override
  State<ParentForm> createState() => _ParentFormState();
}

class _ParentFormState extends State<ParentForm> with TextStyleMixin {
  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  TextStyle registerFormTextStyle() {
    return textstyleSma();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: '登录账号', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validateField(value, "登录账户"),
            onSaved: (value) => widget.parent.accountName = value,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: '你的称呼', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.text,
            validator: (value) => _validateField(value, "您的称呼"),
            onSaved: (value) => widget.parent.name = value,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: '亲子关系', labelStyle: registerFormTextStyle()),
            keyboardType: TextInputType.text,
            validator: (value) => _validateField(value, "角色"),
            onSaved: (value) => widget.parent.role = value,
          )
        ],
      ),
    );
  }
}
