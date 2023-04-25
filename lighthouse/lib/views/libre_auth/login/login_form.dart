// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/global_widgets/elevated_button.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/mixins/loading_mixin.dart';

import 'package:lighthouse/providers/libre_auth_provider.dart';

import 'package:provider/provider.dart';

import '../../../global_widgets/login_email_field.dart';
import '../../../global_widgets/login_password_field.dart';

class LibreLoginForm extends StatefulWidget {
  const LibreLoginForm({Key? key}) : super(key: key);

  @override
  State<LibreLoginForm> createState() => _LibreLoginFormState();
}

class _LibreLoginFormState extends State<LibreLoginForm> with LoadingMixin {
  String userName = '';
  String password = '';
  String pinCode = '';
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Consumer<LibreAuthProvider>(builder: (context, provider, child) {
      return provider.isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginUserInput(
                    hintText: "Email",
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
                  const SizedBox(height: 25),
                  CustomButton(
                    "Login",
                    onpressed: () {
                      if (userName.trim().isEmpty) {
                        Utils.errorSnackBar(context, "Email is Required");
                      } else if (password.trim().isEmpty) {
                        Utils.errorSnackBar(context, "Password is required");
                      } else {
                        provider.loginWithLibre(context: context, email: userName, password: password);
                      }
                    },
                    backgroundColor: Colors.orange[900]!,
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 10),
                ],
              ),
            );
      // : Column(
      //     children: [
      //       SizedBox(
      //         height: size.height * 0.1,
      //       ),
      //       OTPTextField(
      //         length: 6,
      //         width: size.width,
      //         fieldWidth: 40,
      //         style: TextStyle(fontSize: 17),
      //         textFieldAlignment: MainAxisAlignment.spaceAround,
      //         fieldStyle: FieldStyle.box,
      //         onCompleted: (pin) {
      //           print("Completed: " + pin);
      //           setState(() {
      //             pinCode = pin;
      //           });
      //         },
      //       ),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           GestureDetector(
      //               onTap: () {
      //                 if (provider.templibreLoginModel?.data?.authTicket?.token != null) {
      //                   provider.libreSendOTPLibre(context: context, token: provider.templibreLoginModel!.data!.authTicket!.token!);
      //                 } else {
      //                   provider.changeOtpSentStatus(false);
      //                 }
      //               },
      //               child: Text(
      //                 "Resend",
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               ))
      //         ],
      //       ),
      //       SizedBox(
      //         height: size.height * 0.04,
      //       ),
      //       CustomButton(
      //         "Verify",
      //         width: size.width * 0.4,
      //         onpressed: () {
      //           if (pinCode.trim().isEmpty) {
      //             Utils.errorSnackBar(context, "Please enter the otp");
      //           } else {}
      //           provider.libreVerifyLibre(context: context, otp: pinCode);
      //         },
      //         borderColor: Colors.grey,
      //       ),
      //     ],
      //   );
    });
  }
}
