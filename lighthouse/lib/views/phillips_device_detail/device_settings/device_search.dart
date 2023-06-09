// import 'dart:developer';

// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lighthouse/helpers/Utils.dart';
// import 'package:lighthouse/providers/hueHomeProvider.dart';
// import 'package:provider/provider.dart';

// import '../../../global_widgets/input_text_field.dart';
// import '../../../models/device_list_model.dart';
// import '../../../providers/device_details_provider.dart';

// class HueLightSearch extends StatefulWidget {
//   const HueLightSearch({super.key});

//   @override
//   State<HueLightSearch> createState() => _HueLightSearchState();
// }

// class _HueLightSearchState extends State<HueLightSearch> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HueProvider>(builder: (context, provider, child) {
//       return Scaffold(
//         // appBar: baseStyleAppBar(title: '', leadingWidget: Container(), actions: [
//         //   IconButton(
//         //       onPressed: () {
//         //         provider.canpressLoginButton().then((value) {
//         //           if (value == true) {
//         //             provider.pressLinkButton(context).then((value) => provider.getApplicationKeyOrUserName(context));
//         //           }
//         //         });
//         //       },
//         //       icon: Icon(
//         //         Icons.refresh,
//         //       )),
//         //   IconButton(
//         //       onPressed: () {
//         //         provider.logOut(context);
//         //       },
//         //       icon: Icon(Icons.logout))
//         // ]),
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/bg.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: provider.isLoading
//               ? const Center(
//                   child: CupertinoActivityIndicator(color: Colors.white),
//                 )
//               : RefreshIndicator(
//                   color: Colors.black,
//                   onRefresh: () => provider.canpressLoginButton().then((value) {
//                     if (value == true) {
//                       provider.pressLinkButton(context).then((value) => provider.getApplicationKeyOrUserName(context));
//                     }
//                   }),
//                   child: ListView(
//                     children: [
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                           child: InputTextField(
//                             label: "",
//                             onChanged: (value) {
//                               if (value == null || value == "") {
//                                 log(value);
//                                 log(provider.deviceListModel!.data!.length.toString());
//                                 provider.resetList();
//                                 provider.showHide();
//                               } else {
//                                 provider.resetList();
//                                 provider.onItemChanged(value);
//                                 provider.showHide();
//                               }
//                             },
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(color: Colors.black),
//                                 borderRadius: BorderRadius.circular(15.7),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(15.7),
//                               ),
//                               hintText: "Search lights",
//                               // prefixIcon: Icon(
//                               //   Icons.person,
//                               //   size: 20,
//                               //   color: Theme.of(context).textTheme.overline?.color,
//                               // ),
//                             ),
//                           )),
//                       // const SizedBox(height: 10),
//                       provider.isEmpty
//                           ? const Center(
//                               child: Text("No lights found please make sure you are loged in the phillips hue"),
//                             )
//                           : ListView.builder(
//                               itemCount: provider.deviceListModel == null ? 0 : provider.deviceListModel!.data!.length,
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               padding: const EdgeInsets.symmetric(horizontal: 25),
//                               itemBuilder: (context, index) {
//                                 var device = provider.deviceListModel!.data![index];

//                                 return device.productData!.productArchetype!.contains("bridge")
//                                     ? const SizedBox.shrink()
//                                     : GestureDetector(
//                                         onTap: () {
//                                           if (device.services != null && device.services!.isNotEmpty) {
//                                             // log("services found");
//                                             // inspect(device.services?.firstWhere((element) => element.rtype == "light"));
//                                             Service? service = device.services?.firstWhere((element) => element.rtype == "light");
//                                             // inspect(service);
//                                             try {
//                                               if (service != null) {
//                                                 Navigator.pop(context, service);
//                                                 // Navigator.of(context)
//                                                 //     .push(MaterialPageRoute(builder: (context) => HueDeviceDetails(deviceId: service.rid!)));
//                                               } else {
//                                                 Utils.infoSnackBar(context, "No related service found");
//                                               }
//                                             } catch (e) {
//                                               Utils.infoSnackBar(context, "No related service found");
//                                             }
//                                           }
//                                         },
//                                         child: ListTile(
//                                           leading: Icon(
//                                             CommunityMaterialIcons.lightbulb,
//                                             color: Colors.yellow,
//                                           ),
//                                           title: Text(
//                                             device.metadata?.name ?? "",
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ));
//                               },
//                             )
//                     ],
//                   ),
//                 ),
//         ),
//       );
//     });
//   }
// }
