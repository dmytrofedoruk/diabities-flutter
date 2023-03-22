import 'package:flutter/material.dart';

import 'input_text_field.dart';

typedef PasswordInputCallBack = void Function(String value);

class LoginPasswordInput extends StatefulWidget {
  final PasswordInputCallBack onChanged;
  const LoginPasswordInput({super.key, required this.onChanged});

  @override
  State<LoginPasswordInput> createState() => _LoginPasswordInputState();
}

class _LoginPasswordInputState extends State<LoginPasswordInput> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      label: "",
      onChanged: (value) => widget.onChanged(value),
      obscureText: isSecure,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25.7),
          ),
          hintText: "Password",
          // prefixIcon: Icon(
          //   Icons.lock,
          //   size: 20,
          //   color: Theme.of(context).textTheme.overline?.color,
          // ),
          suffixIcon: IconButton(
            onPressed: () {
              isSecure = !isSecure;
              setState(() {});
            },
            icon: Icon(
              isSecure ? Icons.visibility_off : Icons.visibility,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
            ),
          )),
    );
  }
}
