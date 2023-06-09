import 'package:flutter/material.dart';

import 'input_text_field.dart';

typedef UserNameInputCallBack = void Function(String value);

class LoginUserInput extends StatelessWidget {
  final UserNameInputCallBack onChanged;
  String hintText;
  LoginUserInput({super.key, required this.onChanged, this.hintText = "Email"});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        onChanged(value);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white60),
          borderRadius: BorderRadius.circular(10.7),
        ),
        hintText: hintText,
        // hintStyle: TextStyle()
        // prefixIcon: Icon(
        //   Icons.person,
        //   size: 20,
        //   color: Theme.of(context).textTheme.overline?.color,
        // ),
      ),
    );
  }
}
