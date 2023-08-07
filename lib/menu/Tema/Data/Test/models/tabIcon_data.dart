import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/icon/dashboard_1.png',
      selectedImagePath: 'assets/icon/dashboard_2.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icon/report_1.png',
      selectedImagePath: 'assets/icon/report_2.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icon/game_1.png',
      selectedImagePath: 'assets/icon/game_2.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/icon/usertest.png',
      selectedImagePath: 'assets/icon/usertest_2.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
