import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/models/device_list_model.dart';
import 'package:lighthouse/views/phillips_device_detail/colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/elevated_button.dart';
import '../../../global_widgets/input_text_field.dart';
import '../../../providers/device_details_provider.dart';
import 'device_search.dart';

enum MyColors {
  low,
  high,
  good,
  extremeHigh,
}

class DeviceSettings extends StatefulWidget {
  final String deviceId;
  const DeviceSettings({super.key, required this.deviceId});

  @override
  State<DeviceSettings> createState() => _DeviceSettingsState();
}

class _DeviceSettingsState extends State<DeviceSettings> with AppbarMixin {
  List<TextEditingController> inputControllersList = [];
  List<InputTextField> _fields = [];
  final countryController = TextEditingController();
  Color lowColor = Colors.red;
  Color goodColor = Colors.green;
  Color highColor = Colors.yellow;
  Color extremHigh = Colors.purple;

  Future<void> showColorDialog(MyColors fromString) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: Text(fromString.name),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: fromString == MyColors.low
                  ? lowColor
                  : fromString == MyColors.good
                      ? goodColor
                      : fromString == MyColors.high
                          ? highColor
                          : fromString == MyColors.extremeHigh
                              ? extremHigh
                              : Colors.black,
              onColorChanged: (pickedvalue) {
                // Navigator.pop(context);
                if (fromString == MyColors.low) {
                  setState(() {
                    lowColor = pickedvalue;
                  });
                } else if (fromString == MyColors.good) {
                  setState(() {
                    goodColor = pickedvalue;
                  });
                } else if (fromString == MyColors.high) {
                  setState(() {
                    highColor = pickedvalue;
                  });
                } else if (fromString == MyColors.extremeHigh) {
                  setState(() {
                    extremHigh = pickedvalue;
                  });
                }
              },
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('Cancel'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          child: _fields[index],
        );
      },
    );
  }

  addInputField() {
    final controller = TextEditingController();
    final field = InputTextField(
      enabled: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: "11111111111",
        prefixIcon: CountryCodePicker(
          dialogBackgroundColor: Colors.blue[900],

          textStyle: const TextStyle(color: Colors.white),
          onChanged: (value) {
            log(value.dialCode.toString());
            log(value.name.toString());
          },
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'GB',
          favorite: ['+1', 'FR'],
          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          // optional. aligns the flag and the Text left
          alignLeft: false,
        ),
      ),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );

    setState(() {
      inputControllersList.add(controller);
      _fields.add(field);
    });
  }

  removeInputField() {
    setState(() {
      inputControllersList.removeLast();
      _fields.removeLast();
    });
  }

  final txtlightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<HueDeviceDetailsProvider>(builder: (context, provider, child) {
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
        appBar: baseStyleAppBar(title: "Device Settings"),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: provider.isLoading || device == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HueLightSearch())).then((value) {
                              if (value != null) {
                                provider.getDeviceDetails(context: context, deviceId: value.rid!).then((value) {
                                  txtlightController.text = device.metadata!.name ?? "";
                                });
                              }
                              inspect(value);
                            });
                          },
                          child: AbsorbPointer(
                            child: InputTextField(
                              enabled: false,
                              controller: txtlightController,
                              decoration: InputDecoration(
                                  hintText: "Select light",
                                  prefixIcon: Icon(
                                    Icons.light,
                                    color: theme.primaryColor,
                                  )),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text("Emergnecy Contact", style: TextStyle(color: theme.primaryColor)),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  removeInputField();
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: theme.primaryColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  addInputField();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: theme.primaryColor,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _listView(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Set light color when Sugar Level is:-",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Low",
                              style: TextStyle(fontSize: 18, color: theme.primaryColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                showColorDialog(MyColors.low);
                              },
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(color: lowColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Good",
                              style: TextStyle(fontSize: 18, color: theme.primaryColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                showColorDialog(MyColors.good);
                              },
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(color: goodColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High",
                              style: TextStyle(fontSize: 18, color: theme.primaryColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                showColorDialog(MyColors.high);
                              },
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(color: highColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Extreme High",
                              style: TextStyle(fontSize: 18, color: theme.primaryColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                showColorDialog(MyColors.extremeHigh);
                              },
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(color: extremHigh),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomGradientButton(
                            "Update",
                            onpressed: () {
                              inspect(inputControllersList);
                            },
                            borderColor: Colors.transparent,
                            backgroundColor: const Color.fromRGBO(211, 243, 107, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
