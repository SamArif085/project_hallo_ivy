import 'package:flutter/material.dart';
import '../Quiz/views/list_quiz.dart';
import 'color_Theme.dart';
import 'models/materi_category.dart';
import 'pr_home_page.dart';

class KontenMenuPRandQuiz extends StatefulWidget {
  const KontenMenuPRandQuiz({
    Key? key,
    this.callBack,
  }) : super(key: key);

  final Function()? callBack;

  @override
  _KontenMenuPRandQuizState createState() => _KontenMenuPRandQuizState();
}

class _KontenMenuPRandQuizState extends State<KontenMenuPRandQuiz>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.width <= 600
        ? 180
        : 400; // Mengatur tinggi sesuai dengan kondisi perangkat

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Container(
              height:
                  containerHeight, // Mengatur tinggi sesuai dengan kondisi perangkat
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: getPRUI(),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Expanded(
                    child: getQuizUI(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget getPRUI() {
    double main = 370;
    if (MediaQuery.of(context).size.width <= 600) {
      main = 170;
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: main,
      ),
      itemCount: Category.testcourseList.length,
      itemBuilder: (BuildContext context, int index) {
        final Category category = Category.testcourseList[index];
        final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / Category.testcourseList.length) * index, 1.0,
                curve: Curves.fastOutSlowIn),
          ),
        );
        animationController?.forward();
        return CategoryView(
          callback: widget.callBack,
          category: category,
          animation: animation,
          animationController: animationController,
          onTap: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const PRHome(),
              ),
            );
          },
        );
      },
    );
  }

  Widget getQuizUI() {
    double main = 370;
    if (MediaQuery.of(context).size.width <= 600) {
      main = 170;
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: main,
      ),
      itemCount: Category.popularCourseList.length,
      itemBuilder: (BuildContext context, int index) {
        final Category category = Category.popularCourseList[index];
        final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController!,
            curve: Interval(
                (1 / Category.popularCourseList.length) * index, 1.0,
                curve: Curves.fastOutSlowIn),
          ),
        );
        animationController?.forward();
        return CategoryView2(
          callback: widget.callBack,
          category: category,
          animation: animation,
          animationController: animationController,
          onTap: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const QuizMenu(),
              ),
            );
          },
        );
      },
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    this.category,
    this.animationController,
    this.animation,
    this.callback,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback? callback;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width <= 600
        ? MediaQuery.of(context).size.width * 0.32
        : MediaQuery.of(context).size.width * 0.4;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: onTap,
              child: SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              // border: Border.all(
                              //     color: DesignCourseAppTheme.notWhite),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16,
                                          left: 16,
                                          right: 16,
                                        ),
                                        child: Text(
                                          category!.title,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color:
                                                DesignCourseAppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: SizedBox(
                        width:
                            paddingWidth, // Lebar disesuaikan dengan kondisi perangkat
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(category!.imagePath)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryView2 extends StatelessWidget {
  const CategoryView2({
    Key? key,
    this.category,
    this.animationController,
    this.animation,
    this.callback,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback? callback;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width <= 600
        ? MediaQuery.of(context).size.width * 0.32
        : MediaQuery.of(context).size.width * 0.4;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: onTap,
              child: SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              // border: Border.all(
                              //     color: DesignCourseAppTheme.notWhite),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16,
                                          left: 16,
                                          right: 16,
                                        ),
                                        child: Text(
                                          category!.title,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color:
                                                DesignCourseAppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: SizedBox(
                        width:
                            paddingWidth, // Lebar disesuaikan dengan kondisi perangkat
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(category!.imagePath)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
