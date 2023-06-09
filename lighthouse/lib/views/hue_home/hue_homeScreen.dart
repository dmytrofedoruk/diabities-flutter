// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/device_details_provider.dart';
import 'package:lighthouse/providers/hueHomeProvider.dart';

import 'package:lighthouse/views/hue_home/smartdeiviceBox.dart';
import 'package:provider/provider.dart';

import '../../global_widgets/input_text_field.dart';
import '../../models/device_list_model.dart';

class HueScreen extends StatefulWidget {
  const HueScreen({super.key});

  static const routeName = "homeScreen";

  @override
  State<HueScreen> createState() => _HueScreenState();
}

class _HueScreenState extends State<HueScreen> with AppbarMixin {
  @override
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Consumer<HueProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: InputTextField(
                label: "",
                onChanged: (value) {
                  if (value == null || value == "") {
                    log(value);
                    log(provider.lightsServerModel!.hueLights!.length.toString());
                    provider.resetList();
                    provider.showHide();
                  } else {
                    provider.resetList();
                    provider.onItemChanged(value);
                    provider.showHide();
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.7),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.7),
                  ),
                  hintText: "Search lights",
                  // prefixIcon: Icon(
                  //   Icons.person,
                  //   size: 20,
                  //   color: Theme.of(context).textTheme.overline?.color,
                  // ),
                ),
              )),
          const SizedBox(height: 10),
          provider.isEmpty
              ? Center(
                  child: Text("No lights found"),
                )
              : ListView.builder(
                  itemCount: provider.lightsServerModel == null ? 0 : provider.lightsServerModel!.hueLights!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   childAspectRatio: 1 / 1.3,
                  // ),
                  itemBuilder: (context, index) {
                    provider.lightsServerModel!.hueLights!.sort((a, b) => a.active! ? -1 : 1);
                    var device = provider.lightsServerModel!.hueLights![index];

                    return SmartDeviceBox(
                      smartDeviceName: device.lightName ?? "",
                      deviceType: "",
                      iconPath: "assets/light-bulb.png",
                      isSelected: device.active ?? false,
                      onChanged: (value) {
                        // Provider.of<HueDeviceDetailsProvider>(context, listen: false)
                        //     .changeLightColors(context: context, deviceID: device.lightId!, brightness: 100.0, color: Colors.white);
                        setState(() {
                          device.active = value;
                          // Service? service = device.services?.firstWhere((element) => element.rtype == "light");
                          provider.activateOrDEactivateLight(
                              context: context, deivceId: device.lightId ?? "", deviceName: device.lightName ?? "", isActive: device.active ?? false);
                        });
                      },
                      isOn: device.isOn ?? false,
                      onSaved: () {
                        // Service? service = device.services?.firstWhere((element) => element.rtype == "light");
                        Provider.of<HueDeviceDetailsProvider>(context, listen: false)
                            .turnOnOrOffLight(context: context, deviceId: device.lightId ?? "", isOn: !device.isOn!)
                            .then((value) {
                          // if (value == device.lightId) {
                          setState(() {
                            device.isOn = !device.isOn!;
                          });
                          // }
                        });
                      },
                    );
                  },
                )
        ],
      );
    });
  }
}
