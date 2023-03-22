import 'package:flutter/material.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../global_widgets/elevated_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with AppbarMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(title: "Enter Otp"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 50,
            ),
            const SizedBox(height: 30),
            // Text('', style: theme.textTheme.headline5),
            const SizedBox(height: 10),
            const Text('Please Enter the otp you recived on your mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(
              height: size.height * 0.1,
            ),
            OTPTextField(
              length: 6,
              width: size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomButton(
              "Verify",
              width: size.width * 0.4,
              onpressed: () {},
              borderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
