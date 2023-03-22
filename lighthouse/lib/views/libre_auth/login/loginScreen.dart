import 'package:flutter/material.dart';
import 'package:lighthouse/views/theme/colors.dart';

import 'login_container.dart';
import 'login_form.dart';

class LibreLoginScreen extends StatelessWidget {
  const LibreLoginScreen({super.key});
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
      body: LibreLoginContainer(
        heading: Column(
          children: [
            Image.asset(
              "assets/download.png",
              height: 50,
            ),
            const SizedBox(height: 30),
            // Text('Libreview Login', style: theme.textTheme.headline5),
            // const SizedBox(height: 10),
            const Text('Enter libreview creadentails to continue ', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400)),
          ],
        ),
        form: const LibreLoginForm(),
      ),
    );
  }
}
