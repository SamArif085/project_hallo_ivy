import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Game/Game1.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Quiz/views/homepage.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/testPopular.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/video_screen.dart';

import '../../../../login.dart';
import 'category_list_view.dart';
import 'course_info_screen.dart';
import 'design_course_app_theme.dart';
import 'game_list_view.dart';

class DesignCourseHomeScreen extends StatefulWidget {
  final String username;
  final String password;
  final UserData userData;

  const DesignCourseHomeScreen({
    Key? key,
    this.animationController,
    required this.username,
    required this.password,
    required this.userData,
  }) : super(key: key);
  final AnimationController? animationController;

  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {
  String contentTypeToShow = '';
  void toggleViews() {
    setState(() {
      contentTypeToShow = (contentTypeToShow == 'game')
          ? 'quiz'
          : 'game'; // Toggle antara game dan quiz saat tombol ditekan
    });
  }

  @override
  void initState() {
    super.initState();
    toggleViews(); // Ini akan menampilkan konten game saat halaman dimuat.
  }

  CategoryType categoryType = CategoryType.ui;
  bool showTestPopularView = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      //   Flexible(
                      //   child: getPopularCourseUI(),
                      // ),
                      Flexible(
                        child: getCategoryUI(),
                      ),
                      // Flexible(
                      //   child: getGameUI(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 18, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //  Padding(
          //   padding: EdgeInsets.only(top: 0.0, left: 18, right: 16),
          //   child: Text(
          //     'Materi',
          //     textAlign: TextAlign.left,
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //       fontSize: 22,
          //       letterSpacing: 0.27,
          //       color: DesignCourseAppTheme.darkerText,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          const Text(
            'Materi',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: CategoryListView(
              callBack: () {
                moveToMateri();
              },
            ),
          ),
          Visibility(
            visible: contentTypeToShow ==
                'game', // Tampilkan hanya jika konten yang ingin ditampilkan adalah game
            child: Flexible(
              child: TestPopularView(
                contentType:
                    contentTypeToShow, // Berikan nilai contentTypeToShow ke parameter contentType
                callBack: toggleViews,
              ),
            ),
          ),
          Visibility(
            visible: contentTypeToShow ==
                'quiz', // Tampilkan hanya jika konten yang ingin ditampilkan adalah quiz
            child: Flexible(
              child: TestPopularView(
                contentType:
                    contentTypeToShow, // Berikan nilai contentTypeToShow ke parameter contentType
                callBack: toggleViews,
              ),
            ),
          ),
          const Text(
            'Game',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: GameListView(
              callBack: () {
                moveTo();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getGameUI() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 0.0, left: 18, right: 16),
          child: Text(
            'Game',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        // GameListView(
        //   callBack: () {
        //     moveTo();
        //   },
        // ),
        //  SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // const Text(
          //   'Popular Course',
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 22,
          //     letterSpacing: 0.27,
          //     color: DesignCourseAppTheme.darkerText,
          //   ),
          // ),
          // Flexible(
          //   child: PopularCourseListView(
          //     callBack: () {
          //       moveTo();
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const CourseInfoScreen(),
      ),
    );
  }

  void moveToMateri() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>
            VideoScreen(userData: widget.userData),
      ),
    );
  }

  void moveToQuiz(String pageToMove) {
    if (pageToMove == 'quiz') {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    } else if (pageToMove == 'game') {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const Game1(),
        ),
      );
    }
  }

  //   void moveToQuiz() {
  //  Navigator.push<dynamic>(
  //     context,
  //     MaterialPageRoute<dynamic>(
  //       builder: (BuildContext context) => const HomePage(page: 'quiz',),
  //     ),
  //   );
  // }

  // Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
  //   String txt = '';
  //   if (CategoryType.ui == categoryTypeData) {
  //     txt = 'Ui/Ux';
  //   } else if (CategoryType.coding == categoryTypeData) {
  //     txt = 'Coding';
  //   } else if (CategoryType.basic == categoryTypeData) {
  //     txt = 'Basic UI';
  //   }
  //   return Expanded(
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: isSelected
  //               ? DesignCourseAppTheme.nearlyBlue
  //               : DesignCourseAppTheme.nearlyWhite,
  //           borderRadius: const BorderRadius.all(Radius.circular(24.0)),
  //           border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
  //       child: Material(
  //         color: Colors.transparent,
  //         child: InkWell(
  //           splashColor: Colors.white24,
  //           borderRadius: const BorderRadius.all(Radius.circular(24.0)),
  //           onTap: () {
  //             setState(() {
  //               categoryType = categoryTypeData;
  //             });
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //                 top: 12, bottom: 12, left: 18, right: 18),
  //             child: Center(
  //               child: Text(
  //                 txt,
  //                 textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 12,
  //                   letterSpacing: 0.27,
  //                   color: isSelected
  //                       ? DesignCourseAppTheme.nearlyWhite
  //                       : DesignCourseAppTheme.nearlyBlue,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.userData.values.kelas,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  widget.userData.values.nama,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/design_course/userImage.png'),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
