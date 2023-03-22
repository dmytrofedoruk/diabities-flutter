import 'package:flutter/material.dart';
import 'package:lighthouse/views/theme/colors.dart';

import 'login_container.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // String greeting = greeting();

    return Scaffold(
      body: LoginContainer(
        heading: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 100,
              color: Colors.blue[900],
              width: double.infinity,
            ),
            const SizedBox(height: 30),
            Text('Good ${greeting()} 👋', style: theme.textTheme.headline5),
            const SizedBox(height: 10),
            const Text('Lorem ipsum dolor sit amet consectetu', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400)),
          ],
        ),
        form: const LoginForm(),
      ),
    );
  }
}
