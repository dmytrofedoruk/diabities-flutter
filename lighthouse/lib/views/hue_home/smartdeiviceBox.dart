import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final String deviceType;
  final bool isSelected;
  final bool isOn;

  final void Function()? onSaved;
  final void Function(bool?)? onChanged;

  const SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.deviceType,
    required this.isSelected,
    required this.onChanged,
    required this.isOn,
    this.onSaved,
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
          color: Colors.grey[900],
        ),
        child: CheckboxListTile(
          title: Text(
            smartDeviceName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            deviceType,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          secondary: GestureDetector(
            onTap: onSaved,
            child: Image.asset(
              iconPath,
              height: 30,
              width: 30,
              color: isOn ? Colors.yellow : Colors.grey,
            ),
          ),
          value: isSelected,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
