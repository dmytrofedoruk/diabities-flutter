// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/global_widgets/elevated_button.dart';
import 'package:lighthouse/mixins/loading_mixin.dart';
import 'package:lighthouse/providers/app_auth_provider.dart';
import 'package:lighthouse/views/auth/otp/otp_screen.dart';
import 'package:lighthouse/views/auth/signup/signup_screen.dart';
import 'package:lighthouse/views/dashboard/dashboard_tabs.dart';
import 'package:provider/provider.dart';

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
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    var theme = Theme.of(context);
    return Consumer<AppAuthProvider>(builder: (context, provider, child) {
      // var formmat = DateFormat('MMM dd');
      return provider.isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            )
          : Align(
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
                        scale: 1.2,
                        child: Checkbox(
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          checkColor: Colors.black,
                          activeColor: Colors.black,
                          // fillColor: MaterialStateProperty.resolveWith(colorThemeLight.primaryColorLight),
                          value: isRemember,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          onChanged: (bool? value) {
                            setState(() {
                              isRemember = value!;
                              provider.rememebme = isRemember;
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
                      provider.isValid(email: userName, password: password, context: context);
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
                  CustomGradientButton(
                    "Signup",
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBoardTabs()));
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
    });
  }
}
