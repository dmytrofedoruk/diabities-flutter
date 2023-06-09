import 'package:flutter/material.dart';

import '../../../global_widgets/custom_gradient_button.dart';
import '../../../global_widgets/elevated_button.dart';
import '../../../global_widgets/image_button.dart';
import '../../dashboard/dashboard_tabs.dart';

class DeviceSelectionScreen extends StatelessWidget {
  const DeviceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.22,
                ),
                Text(
                  'Welcome!',
                  style: theme.textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "First of all let’s connect your CGM. We support both Libre and Dexcom, simply choose which you use and enter your details to get started.",
                  style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.037),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ImageButton(
                              width: size.width * 0.3,
                              backgroundColor: Colors.white,
                              imagePath: "assets/freestyle.png",
                              onpressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DashBoardTabs()));
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ImageButton(
                              width: size.width * 0.3,
                              backgroundColor: Colors.green,
                              imagePath: "assets/dexcom1.png",
                              onpressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Connected ",
                            style: TextStyle(color: Colors.white, fontSize: size.width * 0.046, fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "You can also connect your smart light by clicking the button below: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.036,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    width: size.width * 0.6,
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
                          // width: size.width * 0.3,
                          backgroundColor: Colors.white,
                          imagePath: "assets/hue_brand.png",
                          onpressed: () {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Disconnected ",
                              style: TextStyle(color: Colors.white, fontSize: size.width * 0.046, fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.fiber_manual_record,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ],
                    )),

                // CustomGradientButton(
                //   "Connect CGM",
                //   onpressed: () {},
                // ),

                const SizedBox(
                  height: 20,
                ),
                // RichText(
                //   text: TextSpan(
                //       text: 'And the best part?',
                //       style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.037),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: 'It’s free.',
                //           style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.037, fontWeight: FontWeight.w500),
                //         )
                //       ]),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
