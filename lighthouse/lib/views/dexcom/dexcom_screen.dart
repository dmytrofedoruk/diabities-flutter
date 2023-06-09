import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lighthouse/global_widgets/custom_gradient_button.dart';
import 'package:lighthouse/mixins/appbar_mixins.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:lighthouse/views/nightScout/nighScout_url/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../global_widgets/elevated_button.dart';
import '../../global_widgets/image_button.dart';
import 'dexcom_login/loginScreen.dart';

class DexcomHomeScreen extends StatefulWidget {
  const DexcomHomeScreen({super.key});

  @override
  State<DexcomHomeScreen> createState() => _DexcomHomeScreenState();
}

class _DexcomHomeScreenState extends State<DexcomHomeScreen> with AppbarMixin {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // var libreHomeProvider = Provider.of<LibreHomeProvider>(context, listen: false);
      // libreHomeProvider.checkLibreTokenExist().then((value) {
      //   if (value == true) {
      //     Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(
      //       context: context,
      //     );
      //   }
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var libreAuthProvider = Provider.of<LibreAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(body: Consumer<LibreHomeProvider>(builder: (context, provider, child) {
      var formmat = DateFormat('MMM dd');
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: provider.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                // Provider.of<LibreHomeProvider>(context, listen: false).checkLibreTokenExist().then((value) {
                                //   if (value == true) {
                                //     Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(
                                //       context: context,
                                //     );
                                //   }
                                // });
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                // Provider.of<LibreHomeProvider>(context, listen: false).logout(context);
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        'CGM Settings',
                        style: theme.textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Connect your CGM by pressing the logo below \nPlease ensure ",
                        style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
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
                            Text(
                              "Please ensure ",
                              style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: theme.accentColor,
                                  size: size.width * 0.049,
                                ),
                                Text(
                                  " Libre account is LibreLinkup",
                                  style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: theme.accentColor,
                                  size: size.width * 0.049,
                                ),
                                Text(
                                  " Dexcom is the follower account",
                                  style: TextStyle(color: theme.primaryColor, fontSize: size.width * 0.039),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            ImageButton(
                              width: size.width * 0.8,
                              backgroundColor: Colors.white,
                              imagePath: "assets/freestyle.png",
                              onpressed: () {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ImageButton(
                              width: size.width * 0.8,
                              backgroundColor: Colors.green,
                              imagePath: "assets/dexcom1.png",
                              onpressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const FractionallySizedBox(heightFactor: 0.9, child: DexcomLoginScreen());
                                  },
                                  backgroundColor: theme.primaryColorDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ImageButton(
                              width: size.width * 0.8,
                              backgroundColor: Colors.black,
                              imagePath: "assets/nightscout.png",
                              onpressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const FractionallySizedBox(heightFactor: 0.9, child: NightScoutScreen());
                                  },
                                  backgroundColor: theme.primaryColorDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Connected ",
                                  style: TextStyle(color: Colors.white, fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
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
                    ],
                  ),
                ),
        ),
      );
    }));
  }
}
