import 'package:flutter/material.dart';
import 'package:lighthouse/views/auth/signup/signip_container.dart';
import 'package:lighthouse/views/auth/signup/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    // String greeting = greeting();

    return Scaffold(
      body: SignUpContainer(
        heading: Column(
          children: [
            Image.asset(
              "assets/logo_white.png",
              height: 80,
              width: size.width * 0.6,
            ),
            // const SizedBox(height: 30),
            // Text('Good ${greeting()} 👋', style: theme.textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 10),
            // const Text('Lorem ipsum dolor sit amet consectetu', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
          ],
        ),
        form: const SignUpForm(),
      ),
    );
  }
}
