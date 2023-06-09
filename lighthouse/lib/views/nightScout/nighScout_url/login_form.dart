// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lighthouse/global_widgets/elevated_button.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/mixins/loading_mixin.dart';
import 'package:lighthouse/providers/dexcom_provider.dart';
import 'package:lighthouse/providers/libre_auth_provider.dart';

import 'package:provider/provider.dart';

import '../../../global_widgets/login_email_field.dart';
import '../../../global_widgets/login_password_field.dart';

class NightScoutUrlForm extends StatefulWidget {
  const NightScoutUrlForm({Key? key}) : super(key: key);

  @override
  State<NightScoutUrlForm> createState() => _NightScoutUrlFormState();
}

class _NightScoutUrlFormState extends State<NightScoutUrlForm> with LoadingMixin {
  String url = '';

  bool isRemember = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DexcomProvider>(context, listen: false).getNightScoutUrl(context: context).then((value) {
        url = Provider.of<DexcomProvider>(context, listen: false).currentNightScoutUrl;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Consumer<DexcomProvider>(builder: (context, provider, child) {
      return provider.isLoading
          ? Center(child: buildLoading())
          : Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginUserInput(
                    hintText: provider.currentNightScoutUrl,
                    onChanged: (String value) {
                      url = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 25),
                  CustomButton(
                    "Add url",
                    onpressed: () {
                      if (url.trim().isEmpty) {
                        Utils.errorSnackBar(context, "Url is Required");
                      } else if (!Uri.parse(url).isAbsolute) {
                        Utils.errorSnackBar(context, "Enter a valid Url e.g  https://olliemillskidals.ns.10be.de");
                      } else {
                        provider.addNightScoutUrl(context: context, url: url);
                      }
                    },
                    backgroundColor: Colors.green[400]!,
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
