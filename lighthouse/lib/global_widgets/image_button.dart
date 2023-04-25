import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final double width;
  final VoidCallback onpressed;
  Color backgroundColor;
  Color borderColor;
  String imagePath;

  ImageButton({
    Key? key,
    this.width = double.infinity,
    required this.onpressed,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onpressed,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: width,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.7),
              )),
          child: Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
