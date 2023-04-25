import 'package:flutter/material.dart';
import 'package:lighthouse/global_widgets/elevated_button.dart';
import 'package:lighthouse/views/auth/login/deivce_selection_screen.dart';
import 'package:lighthouse/views/auth/login/loginScreen.dart';
import 'package:lighthouse/views/auth/signup/signup_screen.dart';

import '../../../global_widgets/custom_gradient_button.dart';

class JoiningScreen extends StatelessWidget {
  const JoiningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.29,
                ),
                Text(
                  'Easier life with\n Diabetes',
                  style: theme.textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomGradientButton(
                  "Join now",
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                  },
                ),
                CustomButton(
                  "Existing User",
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  borderColor: const Color.fromRGBO(47, 121, 185, 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Having diabetes shouldn’t be hard. In just 4 steps you enter your blood glucose, the meal you intend to eat, your level of activity, and Lighthouse gives you a suggested insulin dosage",
                  style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.037),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: 'And the best part?',
                      style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.037),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'It’s free.',
                          style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.037, fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
