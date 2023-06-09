import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';

import 'package:lighthouse/providers/EmergencyCallProvider.dart';

import 'package:provider/provider.dart';

import '../../../global_widgets/gradient_container.dart';
import '../../../global_widgets/input_text_field.dart';

import 'device_search.dart';

class DeviceSettings extends StatefulWidget {
  final String deviceId;
  const DeviceSettings({super.key, required this.deviceId});

  @override
  State<DeviceSettings> createState() => _DeviceSettingsState();
}

class _DeviceSettingsState extends State<DeviceSettings> with AppbarMixin {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<EmergencyCallProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getEmergencyNumbers(context: context).then((value) {
        if (provider.emergencyNumberModel?.phoneNumbers != null) {
          for (var i = 0; i < provider.emergencyNumberModel!.phoneNumbers!.length; i++) {
            addInputField();
            inputControllersList[i].text = provider.emergencyNumberModel!.phoneNumbers![i];
          }
        }
        provider.getEmergencyCallingStaus(context: context);
      });
    });
  }

  List<TextEditingController> inputControllersList = [];
  List<InputTextField> _fields = [];
  final countryController = TextEditingController();

  Widget _listView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(20),
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
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(40, 90, 159, 1)),
            borderRadius: BorderRadius.circular(12.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(40, 90, 159, 1)),
            borderRadius: BorderRadius.circular(12.5),
          ),
          hintText: "Enter phone number",
          hintStyle: TextStyle(fontSize: 13),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
            child: Image.asset(
              "assets/uk.png",
              height: 15,
              width: 15,
              fit: BoxFit.contain,
            ),
          )
          // CountryCodePicker(
          //   dialogBackgroundColor: Colors.blue[900],

          //   textStyle: const TextStyle(color: Colors.white),
          //   onChanged: (value) {
          //     log(value.dialCode.toString());
          //     log(value.name.toString());
          //   },
          //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          //   initialSelection: 'GB',
          //   favorite: ['+1', 'FR'],
          //   // optional. Shows only country name and flag
          //   showCountryOnly: true,
          //   showFlagMain: true,

          //   // optional. Shows only country name and flag when popup is closed.
          //   showOnlyCountryWhenClosed: false,
          //   // optional. aligns the flag and the Text left
          //   alignLeft: false,
          // ),
          ),
      keyboardType: TextInputType.phone,
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
  bool isEmergencyNumberOn = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<EmergencyCallProvider>(builder: (context, provider, child) {
      var size = MediaQuery.of(context).size;

      return Scaffold(
        // appBar: baseStyleAppBar(title: "Device Settings"),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: provider.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Text(
                          'LightSync Settings',
                          style: theme.textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          """Lighthouse is will automatically phone you
parents or guardian incase of an urgent low""",
                          style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          """It will also send a What3Words SMS of your 
last known location""",
                          style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039),
                          textAlign: TextAlign.center,
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HueLightSearch())).then((value) {
                        //       if (value != null) {
                        //         provider.getDeviceDetails(context: context, deviceId: value.rid!).then((value) {
                        //           txtlightController.text = device?.metadata!.name ?? "";
                        //         });
                        //       }
                        //       inspect(value);
                        //     });
                        //   },
                        //   child: AbsorbPointer(
                        //     child: InputTextField(
                        //       enabled: false,
                        //       controller: txtlightController,
                        //       decoration: InputDecoration(
                        //           hintText: "Select light",
                        //           prefixIcon: Icon(
                        //             Icons.light,
                        //             color: theme.primaryColor,
                        //           )),
                        //       keyboardType: TextInputType.name,
                        //       textInputAction: TextInputAction.next,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            // Text("Emergnecy Contact", style: TextStyle(color: theme.primaryColor)),
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
                                  if (_fields.length < 4) {
                                    addInputField();
                                  }
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: theme.primaryColor,
                                ))
                          ],
                        ),

                        _listView(),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 100),
                        Center(
                          child: GradientContainer(
                            radius: 40.7,
                            paddinghorizontal: 0,
                            paddingvertical: 0,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Emergency Calling",
                                  style: GoogleFonts.inter(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Switch.adaptive(
                                    onChanged: (value) {
                                      setState(() {
                                        if (value) {
                                          provider
                                              .emergencycallingActive(
                                            context: context,
                                          )
                                              .then((value) {
                                            provider.getEmergencyCallingStaus(context: context);
                                          });
                                        } else {
                                          provider
                                              .emergencycallingInActive(
                                            context: context,
                                          )
                                              .then((value) {
                                            provider.getEmergencyCallingStaus(context: context);
                                          });
                                        }
                                      });
                                    },
                                    value: provider.emergencyCallingActive,
                                    activeColor: Colors.green,
                                    activeTrackColor: const Color.fromRGBO(35, 60, 133, 1),
                                    inactiveThumbColor: Colors.redAccent,
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Emergency Calling On/Off",
                          style: TextStyle(fontSize: 12, color: theme.primaryColor),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomGradientButton(
                            "Update",
                            onpressed: () {
                              if (inputControllersList.isEmpty) {
                                Utils.errorSnackBar(context, "Please add phone number");
                              } else {
                                List<String> numbersList = [];
                                for (var i = 0; i < inputControllersList.length; i++) {
                                  numbersList.add(inputControllersList[i].text);
                                }
                                provider.addEmergencyNumbers(context: context, numbersList: numbersList);
                              }
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
