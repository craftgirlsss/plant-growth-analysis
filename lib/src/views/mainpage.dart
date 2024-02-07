import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_growth/src/views/dashboard/dashboard.dart';

import 'setting/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            )),
            child: NavigationBar(
              labelBehavior: labelBehavior,
              elevation: 0,
              backgroundColor: Colors.green.shade200,
              selectedIndex: currentPageIndex,
              indicatorColor: Colors.black12,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(CupertinoIcons.home),
                  icon: Icon(
                    CupertinoIcons.home,
                    color: Colors.black,
                  ),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  selectedIcon: Icon(CupertinoIcons.settings),
                  icon: Icon(
                    CupertinoIcons.settings,
                    color: Colors.black,
                  ),
                  label: 'Pengaturan',
                ),
              ],
            ),
          ),
        ),
      ),
      body: <Widget>[
        const Dashboard(),
        const SettingPage(),
      ][currentPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        shape: const CircleBorder(),
        color: Colors
            .green.shade400, // container color,to have splash color effect
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: Colors.white10.withOpacity(0.1),
          onTap: () {
            // Get.to(() => const QRCodePage());
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              //         shape: BoxShape.circle,
              shape: BoxShape.circle,
              color: Colors.transparent, // material color will cover this
            ),
            child: const Icon(
              CupertinoIcons.camera,
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
