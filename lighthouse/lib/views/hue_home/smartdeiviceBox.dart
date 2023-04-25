import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final String deviceType;
  final bool powerOn;
  void Function(bool)? onChanged;

  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.deviceType,
    required this.powerOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(35, 60, 133, 1),
                Color.fromRGBO(46, 120, 184, 1),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(24),
          color: powerOn ? Colors.grey[900] : Color.fromARGB(44, 164, 167, 189),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Image.asset(
                iconPath,
                height: 50,
                width: 50,
                color: powerOn ? Colors.white : Colors.grey.shade700,
              ),
              Text(
                smartDeviceName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  fontSize: 12,
                  color: powerOn ? Colors.white : Colors.black,
                ),
              ),
              Text(
                deviceType,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  fontSize: 12,
                  color: powerOn ? Colors.white : Colors.black,
                ),
              ),

              // smart device name + switch
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 25.0),
              //         child: Text(
              //           smartDeviceName,
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             overflow: TextOverflow.visible,
              //             fontSize: 12,
              //             color: powerOn ? Colors.white : Colors.black,
              //           ),
              //         ),
              //       ),
              //     ),
              //     // Transform.rotate(
              //     //   angle: pi / 2,
              //     //   child: CupertinoSwitch(
              //     //     value: powerOn,
              //     //     onChanged: onChanged,
              //     //   ),
              //     // ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
