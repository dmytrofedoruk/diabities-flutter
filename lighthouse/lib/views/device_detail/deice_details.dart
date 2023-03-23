// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lighthouse/helpers/colorHelper.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/device_details_provider.dart';
import 'package:lighthouse/views/device_detail/device_settings/device_settings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../global_widgets/elevated_button.dart';

class DeviceDetails extends StatefulWidget {
  final String deviceId;
  const DeviceDetails({super.key, required this.deviceId});

  @override
  State<DeviceDetails> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> with AppbarMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var deviceDetailsProvider = Provider.of<DeviceDetailsProvider>(context, listen: false);
      deviceDetailsProvider.getDeviceDetails(context: context, deviceId: widget.deviceId);
    });

    super.initState();
  }

  bool isDefault = false;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceDetailsProvider>(builder: (context, provider, child) {
      ColorHelper colorHelper = ColorHelper();

      var device = provider.deviceDetailsModel?.data?.first;
      // final deviceColor = colorHelper.xyToRGB(
      //   device!.color!.xy!.x!,
      //   device.color!.xy!.y!,
      //   50,
      // );

      // inspect(deviceColor);
      // provider.getcolor(device!.color!.xy!.x!, device!.color!.xy!.y!, 100);
      var size = MediaQuery.of(context).size;
      bool? isOn = device?.on?.on ?? false;

      return Scaffold(
          appBar: baseStyleAppBar(title: device?.metadata?.name ?? "", actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DeviceSettings(
                            deviceId: widget.deviceId,
                          )));
                },
                icon: Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  setState(() {
                    isDefault = !isDefault;
                  });
                },
                icon: Icon(isDefault ? CommunityMaterialIcons.heart : CommunityMaterialIcons.heart_outline))
          ]),
          body: provider.isLoading || device == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: size.height * 0.25,
                      width: size.width,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: isOn ? Colors.grey[900] : const Color.fromARGB(44, 164, 167, 189),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // icon

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/light-bulb.png",
                                  height: 50,
                                  width: 50,
                                  color: isOn ? Colors.white : Colors.grey.shade700,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  device?.metadata?.name ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    fontSize: 12,
                                    color: isOn ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // slider,
                                Transform.rotate(
                                  angle: pi / 2,
                                  child: CupertinoSwitch(
                                    activeColor: const Color.fromRGBO(211, 243, 107, 1),
                                    value: isOn,
                                    onChanged: (value) {
                                      setState(() {
                                        isOn = value;
                                        // device?.on?.on = value;
                                      });
                                      provider.turnOnOrOffLight(context: context, deviceId: widget.deviceId, isOn: isOn!).then((value) {
                                        provider.getDeviceDetails(context: context, deviceId: widget.deviceId);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Slider(
                              value: device!.dimming!.brightness!.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 80,
                              activeColor: const Color.fromRGBO(211, 243, 107, 1),
                              onChanged: (value) {},
                              label: "Brightness",
                              onChangeEnd: (double value) {
                                setState(() {
                                  device.dimming!.brightness = value;
                                  // selectedIndex = value.toInt();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ColorPicker(
                      pickerColor: provider.xyToRgb(
                        device!.color!.xy!.x!,
                        device.color!.xy!.y!,
                        50,
                      ),
                      //Color.fromRGBO((deviceColor.red!.toInt() * 255), (deviceColor.green!.toInt() * 255), (deviceColor.blue!.toInt() * 255), 1),
                      onColorChanged: (value) {
                        dev.log(value.toString());
                        color = value;
                      },

                      colorPickerWidth: 250,
                      colorHistory: [Colors.black, Colors.yellow, Colors.red],

                      pickerAreaHeightPercent: 1.0,
                      enableAlpha: false,
                      labelTypes: [],
                      displayThumbColor: true,
                      paletteType: PaletteType.hueWheel,
                      pickerAreaBorderRadius: BorderRadius.circular(150),
                      hexInputBar: false,
                      // colorHistory: widget.colorHistory,
                      // onHistoryChanged: widget.onHistoryChanged,
                    ),
                    // ColorPickerHueRing(HSVColor.fromColor(Colors.red), (value) {}),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        "Update",
                        onpressed: () {
                          // XyzColor xyzColor = XyzColor.fromColor(color!);

                          // inspect(xyzColor);
                          // dev.log(device.dimming!.brightness.toString());
                          provider
                              .changeLightColors(
                                context: context,
                                deviceID: widget.deviceId,
                                brightness: device.dimming?.brightness ?? 100,
                                color: color ?? Colors.white,
                              )
                              .then((value) => provider.getDeviceDetails(context: context, deviceId: widget.deviceId));
                        },
                        borderColor: Colors.transparent,
                        backgroundColor: const Color.fromRGBO(211, 243, 107, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ));
    });
  }
}
