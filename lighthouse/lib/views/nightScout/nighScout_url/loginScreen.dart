import 'package:flutter/material.dart';
import 'package:lighthouse/views/theme/colors.dart';

import 'login_container.dart';
import 'login_form.dart';

class NightScoutScreen extends StatelessWidget {
  const NightScoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: NightScoutContainer(
        heading: Column(
          children: [
            Image.asset(
              "assets/nightscout.png",
              height: 50,
            ),
            const SizedBox(height: 30),
            // Text('Libreview Login', style: theme.textTheme.headline5),
            // const SizedBox(height: 10),
            const Text('Enter night scout url to continue ', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400)),
          ],
        ),
        form: const NightScoutUrlForm(),
      ),
    );
  }
}
