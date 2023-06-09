import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final double paddingvertical;
  final double paddinghorizontal;
  final double radius;
  const GradientContainer({super.key, required this.child, required this.paddingvertical, required this.paddinghorizontal, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingvertical, horizontal: paddinghorizontal),
      decoration: BoxDecoration(
          // color: backgroundColor,
          gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(54, 139, 225, 1),
                Color.fromRGBO(40, 90, 159, 1),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          border: Border.all(color: Colors.transparent),
          borderRadius: const BorderRadius.all(
            Radius.circular(40.7),
          )),
      child: child,
    );
  }
}
