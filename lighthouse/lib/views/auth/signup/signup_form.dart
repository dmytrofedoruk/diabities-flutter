// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/global_widgets/elevated_button.dart';
import 'package:lighthouse/mixins/loading_mixin.dart';
import 'package:lighthouse/providers/app_auth_provider.dart';

import 'package:provider/provider.dart';
import 'dart:developer';
import '../../../global_widgets/login_email_field.dart';
import '../../../global_widgets/login_password_field.dart';
import '../../../helpers/Utils.dart';

enum SubScriptionType { monthly, yearly }

class SignUpForm extends StatefulWidget with LoadingMixin {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String userName = '';
  String password = '';
  String name = '';
  SubScriptionType _subType = SubScriptionType.yearly;
  @override
  void initState() {
    userName = "";
    password = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<AppAuthProvider>(builder: (context, provider, child) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
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
                      hintText: "Name",
                      // hintStyle: TextStyle()
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   size: 20,
                      //   color: Theme.of(context).textTheme.overline?.color,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Subscription with 7 days trial',
                    style: TextStyle(color: Colors.white),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Yearly',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio(
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: SubScriptionType.yearly,
                      groupValue: _subType,
                      onChanged: (SubScriptionType? value) {
                        setState(() {
                          _subType = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Monthly',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio(
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: SubScriptionType.monthly,
                      groupValue: _subType,
                      onChanged: (SubScriptionType? value) {
                        setState(() {
                          _subType = value!;
                          log(_subType.name.toString());
                        });
                      },
                    ),
                  ),

                  CustomGradientButton(
                    "Sign up",
                    onpressed: () {
                      if (name.trim().isEmpty) {
                        Utils.errorSnackBar(context, "Name is Required ");
                      } else if (userName.trim().isEmpty) {
                        Utils.errorSnackBar(context, "Email is Required ");
                      } else if (password.trim().isEmpty) {
                        Utils.errorSnackBar(context, "Password is Required ");
                      } else {
                        provider.isValidForSignup(name: name, email: userName, password: password, context: context, subType: _subType.name);
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  // const SizedBox(height: 25),
                  // CustomGradientButton(
                  //   "Yearly Subscription",
                  //   onpressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubscriptionWebview(subscriptionType: "yearly")));
                  //   },
                  //   backgroundColor: theme.primaryColorDark,
                  // ),
                  const SizedBox(height: 10),
                  CustomButton(
                    "Go Back",
                    width: 80,
                    onpressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
    });
  }
}
