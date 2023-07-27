import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/bottom_navigation_view/bottom_bar_view.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/fitness_app_theme.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/models/tabIcon_data.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/training/training_screen.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/game_page.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/home_design_course.dart';

import '../login.dart';
import 'Tema/Data/Test2/profile_screen.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome(
      {super.key,
      required this.username,
      required this.password,
      required this.userData,
     });
  final String username;
  final String password;
  final UserData userData;


  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DesignCourseHomeScreen(
      animationController: animationController, password: widget.password,
      userData: widget.userData, // Gunakan userData dari widget ini
      username: widget.username,
 
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = DesignCourseHomeScreen(
                    animationController: animationController,
                    password: widget.password,
                    userData:
                        widget.userData,// Gunakan userData dari widget ini
                    username: widget.username,
                  );
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      GamePage(userData: widget.userData);
                });
              });
            }else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      UserProfilePage(userData: widget.userData);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
