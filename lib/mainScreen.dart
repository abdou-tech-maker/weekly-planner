// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:weekly_planner/pages/planning.dart';
import 'package:weekly_planner/pages/repartition.dart';

import 'constantes/constantes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [const Planing(), const Repartition()];
  }

  // List Of NAV Bar Items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(Icons.date_range, color: liteTxt),
          icon: const Icon(
            Icons.date_range,
            color: mainColor,
          )),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(
          Icons.place,
          color: liteTxt,
        ),
        icon: const Icon(
          Icons.place,
          color: mainColor,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PersistentTabView(context,
          navBarHeight: 70,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          popAllScreensOnTapAnyTabs: false,
          confineInSafeArea: true,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: const NavBarDecoration(
            colorBehindNavBar: backGround,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 100),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style6),
    );
  }
}
