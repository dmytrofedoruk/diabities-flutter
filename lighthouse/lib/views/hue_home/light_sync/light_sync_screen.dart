import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:lighthouse/views/hue_home/hue_homeScreen.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/gradient_container.dart';
import '../../../global_widgets/image_button.dart';
import '../../../mixins/loading_mixin.dart';
import '../../../providers/hueHomeProvider.dart';
import '../../auth/phillips_autroize/authroize_webview.dart';

enum MyColors { low, high, good, extremeHigh }

class LightSyncScreen extends StatefulWidget {
  const LightSyncScreen({super.key});

  @override
  State<LightSyncScreen> createState() => _LightSyncScreenState();
}

class _LightSyncScreenState extends State<LightSyncScreen> with LoadingMixin {
  Color lowColor = Colors.red;
  Color goodColor = Colors.green;
  Color highColor = Colors.yellow;
  Color extremHigh = Colors.purple;
  bool isSmartLightSyncOn = false;

  Future<void> showColorDialog(MyColors fromString) async {
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false, // user must tap button!
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       // <-- SEE HERE
    //       title: Text(fromString.name),
    //       content: SingleChildScrollView(
    //         child: ColorPicker(
    //           pickerColor: fromString == MyColors.low
    //               ? lowColor
    //               : fromString == MyColors.good
    //                   ? goodColor
    //                   : fromString == MyColors.high
    //                       ? highColor
    //                       : fromString == MyColors.extremeHigh
    //                           ? extremHigh
    //                           : Colors.black,
    //           onColorChanged: (pickedvalue) {
    //             // Navigator.pop(context);
    //             if (fromString == MyColors.low) {
    //               setState(() {
    //                 lowColor = pickedvalue;
    //               });
    //             } else if (fromString == MyColors.good) {
    //               setState(() {
    //                 goodColor = pickedvalue;
    //               });
    //             } else if (fromString == MyColors.high) {
    //               setState(() {
    //                 highColor = pickedvalue;
    //               });
    //             } else if (fromString == MyColors.extremeHigh) {
    //               setState(() {
    //                 extremHigh = pickedvalue;
    //               });
    //             }
    //           },
    //         ),
    //       ),
    //       actions: [
    //         TextButton(
    //           child: const Text(
    //             'Done',
    //             style: TextStyle(color: Colors.green),
    //           ),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var homeProvider = Provider.of<HueProvider>(context, listen: false);
      // if (homeProvider.deviceListModel?.data == null) {
      try {
        homeProvider.getDeviceListFromServer(context);
        // homeProvider.canpressLoginButton().then((value) {
        //   if (value == true) {
        //     homeProvider.pressLinkButton(context).then((value) {
        //       if (value) {
        //         homeProvider.getApplicationKeyOrUserName(context);
        //       }
        //     });
        //   }
        // });
      } catch (e) {
        homeProvider.logOut(context);
      }
      // }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var libreProvider = Provider.of<LibreHomeProvider>(context);
    return Scaffold(body: Consumer<HueProvider>(builder: (context, provider, child) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: provider.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(color: Colors.white),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                            onPressed: () {
                              provider.getDeviceListFromServer(context);
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: theme.primaryColor,
                            ))

                        // IconButton(
                        //     onPressed: () {
                        //       provider.logOut(context);
                        //     },
                        //     icon: Icon(
                        //       Icons.logout,
                        //       color: theme.primaryColor,
                        //     ))
                      ]),
                      SizedBox(
                        height: size.height * 0.08,
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
                        "Connect Philips Hue by pressing the Logo",
                        style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            // color: backgroundColor,
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(35, 60, 133, 1),
                                  Color.fromRGBO(46, 120, 184, 1),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            border: Border.all(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.7),
                            )),
                        child: Column(
                          children: [
                            ImageButton(
                              backgroundColor: Colors.white,
                              imagePath: "assets/hue_brand.png",
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  provider.isHueToken ? "Connected" : "Disconnected ",
                                  style: TextStyle(color: Colors.white, fontSize: size.width * 0.039, fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.fiber_manual_record,
                                  color: provider.isHueToken ? Colors.green : Colors.red,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select LightSync Colours',
                        style: TextStyle(color: Colors.white, fontSize: size.width * 0.042, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showColorDialog(MyColors.good);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(color: goodColor, borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showColorDialog(MyColors.low);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(color: lowColor, borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showColorDialog(MyColors.high);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(color: highColor, borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Range (4-10 mmol)",
                                style: TextStyle(fontSize: 15, color: theme.primaryColor),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Low Range (Below 4 mmol)",
                                style: TextStyle(fontSize: 15, color: theme.primaryColor),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "High Range (Above 10 mmol)",
                                style: TextStyle(fontSize: 15, color: theme.primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                                "SmartLight Sync",
                                style: GoogleFonts.inter(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                              libreProvider.isLoading
                                  ? buildLoading()
                                  : SizedBox(
                                      height: 35,
                                      child: Switch.adaptive(
                                        onChanged: (value) {
                                          setState(() {
                                            if (value) {
                                              libreProvider.lightSyncActive(context: context).then((value) {
                                                libreProvider.getlightSyncStaus(context: context);
                                              });
                                            } else {
                                              libreProvider.lightSyncInActive(context: context).then((value) {
                                                libreProvider.getlightSyncStaus(context: context);
                                              });
                                            }
                                          });
                                        },
                                        value: libreProvider.lightSyncStatus,
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
                        "Toggle LightSync On/Off",
                        style: TextStyle(fontSize: 12, color: theme.primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const HueScreen(),
                    ],
                  ),
                ),
              ),
      );
    }));
  }
}
