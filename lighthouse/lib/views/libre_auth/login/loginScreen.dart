import 'package:flutter/material.dart';
import 'package:lighthouse/views/theme/colors.dart';

import 'login_container.dart';
import 'login_form.dart';

class LibreLoginScreen extends StatelessWidget {
  const LibreLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // String greeting = greeting();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: LibreLoginContainer(
          heading: Column(
            children: [
              Image.asset(
                "assets/download.png",
                height: 50,
              ),
              const SizedBox(height: 30),
              // Text('Libreview Login', style: theme.textTheme.headline5),
              // const SizedBox(height: 10),
              const Text('Enter libreview creadentails to continue ',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
            ],
          ),
          form: const LibreLoginForm(),
        ),
      ),
    );
  }
}
