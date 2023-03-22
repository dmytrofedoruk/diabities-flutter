// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lighthouse/global_widgets/elevated_button.dart';
import 'package:lighthouse/mixins/loading_mixin.dart';
import 'package:lighthouse/providers/dashboard_provider.dart';
import 'package:lighthouse/views/auth/autroize/authroize_webview.dart';
import 'package:lighthouse/views/auth/otp/otp_screen.dart';
import 'package:lighthouse/views/dashboard/dashboard_tabs.dart';
import 'package:lighthouse/views/home/homeScreen.dart';
import 'package:lighthouse/views/theme/colors.dart';

import '../../../global_widgets/login_email_field.dart';
import '../../../global_widgets/login_password_field.dart';

class LoginForm extends StatefulWidget with LoadingMixin {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String userName = '';
  String password = '';
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginUserInput(
            onChanged: (String value) {
              userName = value;
            },
          ),
          const SizedBox(height: 20),
          LoginPasswordInput(
            onChanged: (String value) {
              password = value;
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: theme.primaryColorDark,
                  // fillColor: MaterialStateProperty.resolveWith(colorThemeLight.primaryColorLight),
                  value: isRemember,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  onChanged: (bool? value) {
                    setState(() {
                      isRemember = value!;
                    });
                  },
                ),
              ),
              const Text(
                'Remeber me',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Spacer(),
              const Text(
                "Forget password?",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 25),
          CustomButton(
            "Login",
            onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen()));
            },
            borderColor: Colors.grey,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 1,
                color: Colors.grey,
              ),
              const Text(
                'or',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
          CustomButton(
            "Proceed",
            onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBoardTabs()));
              // showModalBottomSheet<void>(
              //   // context and builder are
              //   // required properties in this widget
              //   context: context,
              //   isScrollControlled: true,

              //   builder: (BuildContext context) {
              //     // we set up a container inside which
              //     // we create center column and display text

              //     // Returning SizedBox instead of a Container
              //     return FractionallySizedBox(heightFactor: 0.9, child: AuthroizeWebview());
              //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthroizeWebview()));
              //   },
              //   backgroundColor: theme.primaryColorDark,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              // );
            },
            backgroundColor: theme.primaryColorDark,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
