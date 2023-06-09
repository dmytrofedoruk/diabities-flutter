import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onpressed;
  Color backgroundColor;
  Color borderColor;
  Color textColor;
  CustomButton(this.text,
      {Key? key,
      this.width = double.infinity,
      required this.onpressed,
      this.backgroundColor = Colors.transparent,
      this.textColor = Colors.white,
      this.borderColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onpressed,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 50,
          width: width,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.7),
              )),
          child: Center(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 15)),
          ),
        ));
  }
}
