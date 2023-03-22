import 'package:flutter/material.dart';

import 'input_text_field.dart';

typedef UserNameInputCallBack = void Function(String value);

class LoginUserInput extends StatelessWidget {
  final UserNameInputCallBack onChanged;
  String hintText;
  LoginUserInput({super.key, required this.onChanged, this.hintText = "Email"});

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      label: "",
      onChanged: (value) {
        onChanged(value);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(25.7),
        ),
        hintText: hintText,
        // prefixIcon: Icon(
        //   Icons.person,
        //   size: 20,
        //   color: Theme.of(context).textTheme.overline?.color,
        // ),
      ),
    );
  }
}
