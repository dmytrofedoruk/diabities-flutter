import 'package:flutter/material.dart';

class CustomColorPicker extends StatefulWidget {
  final Function(Color) onColorSelected;

  CustomColorPicker({required this.onColorSelected});

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  double _hue = 0.0;
  double _saturation = 1.0;
  double _value = 1.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(alignment: Alignment.center, children: [
      Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              HSVColor.fromAHSV(1.0, 0.0, _saturation, _value).toColor(),
              HSVColor.fromAHSV(1.0, 60.0, _saturation, _value).toColor(),
              HSVColor.fromAHSV(1.0, 120.0, _saturation, _value).toColor(),
              HSVColor.fromAHSV(1.0, 180.0, _saturation, _value).toColor(),
              HSVColor.fromAHSV(1.0, 240.0, _saturation, _value).toColor(),
              HSVColor.fromAHSV(1.0, 300.0, _saturation, _value).toColor(),
              HSVColor.fromAHSV(1.0, 360.0, _saturation, _value).toColor(),
            ],
            stops: [
              0.0,
              1.0 / 6.0,
              2.0 / 6.0,
              3.0 / 6.0,
              4.0 / 6.0,
              5.0 / 6.0,
              1.0,
            ],
          ),
        ),
      ),
      Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor(),
        ),
        child: IconButton(
          icon: Icon(Icons.brush, color: Colors.white),
          onPressed: () {
            if (widget.onColorSelected != null) {
              widget.onColorSelected(HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor());
            }
          },
        ),
      ),
      Positioned(
        top: -10.0,
        child: Slider(
          value: _hue,
          min: 0.0,
          max: 360.0,
          onChanged: (value) {
            setState(() {
              _hue = value;
            });
          },
        ),
      ),
      Positioned(
        right: -10.0,
        child: Slider(
          value: _saturation,
          min: 0.0,
          max: 1.0,
          onChanged: (value) {
            setState(() {
              _saturation = value;
            });
          },
        ),
      ),
      Positioned(
          bottom: -10.0,
          child: Slider(
              value: _value,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              }))
    ]));
  }
}
