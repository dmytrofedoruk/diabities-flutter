// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/homeProvider.dart';

import 'package:lighthouse/views/device_detail/deice_details.dart';
import 'package:lighthouse/views/home/smartdeiviceBox.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../global_widgets/elevated_button.dart';
import '../../global_widgets/input_text_field.dart';
import '../../models/device_list_model.dart';
import '../auth/autroize/authroize_webview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AppbarMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      if (homeProvider.deviceListModel?.data == null) {
        try {
          homeProvider.canpressLoginButton().then((value) {
            if (value == true) {
              homeProvider.pressLinkButton(context).then((value) => homeProvider.getApplicationKeyOrUserName(context));
            }
          });
        } catch (e) {
          homeProvider.logOut(context);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: baseStyleAppBar(title: '', leadingWidget: Container(), actions: [
          IconButton(
              onPressed: () {
                provider.canpressLoginButton().then((value) {
                  if (value == true) {
                    provider.pressLinkButton(context).then((value) => provider.getApplicationKeyOrUserName(context));
                  }
                });
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                provider.logOut(context);
              },
              icon: Icon(Icons.logout))
        ]),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : RefreshIndicator(
                color: Colors.black,
                onRefresh: () => provider.canpressLoginButton().then((value) {
                  if (value == true) {
                    provider.pressLinkButton(context).then((value) => provider.getApplicationKeyOrUserName(context));
                  }
                }),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome ,",
                            style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.grey.shade800),
                          ),
                          Text(
                            'Dashboard',
                            style: GoogleFonts.bebasNeue(fontSize: 42),
                          ),
                        ],
                      ),
                    ),
                    provider.isHueToken
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: InputTextField(
                              label: "",
                              onChanged: (value) {
                                if (value == null || value == "") {
                                  log(value);
                                  log(provider.deviceListModel!.data!.length.toString());
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
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.7),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15.7),
                                ),
                                hintText: "Search lights",
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   size: 20,
                                //   color: Theme.of(context).textTheme.overline?.color,
                                // ),
                              ),
                            ))
                        : Center(
                            child: CustomButton(
                              "Connect With Hue",
                              width: size.width * 0.8,
                              onpressed: () {
                                showModalBottomSheet<void>(
                                  // context and builder are
                                  // required properties in this widget
                                  context: context,
                                  isScrollControlled: true,

                                  builder: (BuildContext context) {
                                    // we set up a container inside which
                                    // we create center column and display text

                                    // Returning SizedBox instead of a Container
                                    return FractionallySizedBox(heightFactor: 0.9, child: AuthroizeWebview());
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthroizeWebview()));
                                  },
                                  backgroundColor: theme.primaryColorDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                              },
                              backgroundColor: theme.primaryColorDark,
                            ),
                          ),
                    const SizedBox(height: 10),
                    provider.isEmpty
                        ? Center(
                            child: Text("No lights found"),
                          )
                        : GridView.builder(
                            itemCount: provider.deviceListModel == null ? 0 : provider.deviceListModel!.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.3,
                            ),
                            itemBuilder: (context, index) {
                              var device = provider.deviceListModel!.data![index];

                              return device.productData!.productArchetype!.contains("bridge")
                                  ? SizedBox.shrink()
                                  : GestureDetector(
                                      onTap: () {
                                        if (device.services != null && device.services!.isNotEmpty) {
                                          log("services found");
                                          inspect(device.services?.firstWhere((element) => element.rtype == "light"));
                                          Service? service = device.services?.firstWhere((element) => element.rtype == "light");
                                          inspect(service);
                                          try {
                                            if (service != null) {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(builder: (context) => DeviceDetails(deviceId: service.rid!)));
                                            } else {
                                              Utils.infoSnackBar(context, "No related service found");
                                            }
                                          } catch (e) {
                                            Utils.infoSnackBar(context, "No related service found");
                                          }
                                        }
                                      },
                                      child: SmartDeviceBox(
                                        smartDeviceName: device.metadata?.name ?? "",
                                        deviceType: device.productData?.productArchetype ?? "",
                                        iconPath: "assets/light-bulb.png",
                                        powerOn: true,
                                        onChanged: (value) {},
                                      ),
                                    );
                            },
                          )
                  ],
                ),
              ),
      );
    });
  }
}
