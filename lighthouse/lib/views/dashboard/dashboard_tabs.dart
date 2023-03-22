// ignore_for_file: use_build_context_synchronously, unused_import

import 'dart:convert';
import 'dart:developer';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lighthouse/providers/dashboard_provider.dart';
import 'package:lighthouse/views/dexcom/dexcom_screen.dart';
import 'package:lighthouse/views/home/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global_widgets/bottom_bar.dart';
import '../../helpers/style_constants.dart';
import '../libreview/libreview_screen.dart';

// class HomeScreen extends StatelessWidget {
//   static const routeName = '/home';

//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const HomeTabs();
//   }
// }

class DashBoardTabs extends StatefulWidget {
  const DashBoardTabs({Key? key}) : super(key: key);

  @override
  State<DashBoardTabs> createState() => _DashBoardTabsState();
}

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

class _DashBoardTabsState extends State<DashBoardTabs> {
  Future<bool> back() async {
    return false;
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const LibreViewScreen(),
    const DexcomHomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(Provider.of<DashBoardProvider>(context, listen: false).selectedIndex),
        ),
        bottomNavigationBar: BottomBarDefault(
          items: const [
            TabItem(
              icon: CommunityMaterialIcons.view_dashboard,
              title: "",
            ),
            TabItem(
              icon: CommunityMaterialIcons.devices,
              title: "",
            ),
            TabItem(
              icon: CommunityMaterialIcons.dip_switch,
              title: "",
            ),
          ],
          backgroundColor: theme.cardColor,
          color: theme.textTheme.caption!.color!,
          colorSelected: theme.primaryColor,
          animated: true,
          indexSelected: Provider.of<DashBoardProvider>(context, listen: true).selectedIndex,
          iconSize: 24,
          top: 10,
          bottom: 10,
          titleStyle: theme.textTheme.overline?.copyWith(fontSize: 11, fontWeight: FontWeight.w700),
          boxShadow: StyleConstants.initShadow,
          onTap: (val) {
            Provider.of<DashBoardProvider>(context, listen: false).selectTab(val);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, {required IconData icon, required Widget title}) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: theme.dividerColor, width: 0.5))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(icon, color: theme.textTheme.overline?.color),
          ),
          title,
        ],
      ),
    );
  }
}
