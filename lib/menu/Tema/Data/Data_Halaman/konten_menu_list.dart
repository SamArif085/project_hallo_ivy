import 'package:flutter/material.dart';
import '../Quiz/views/play_quiz.dart';
import 'color_Theme.dart';
import 'models/materi_category.dart';
import 'pr_home.dart';

class KontenMenuPRandQuiz extends StatefulWidget {
  const KontenMenuPRandQuiz({Key? key, this.callBack, }) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Row(
              // Menggunakan Row untuk mengatur konten secara horizontal
              children: <Widget>[
                Expanded(
                  child: getPRUI(), // Konten 'game' berada di sebelah kiri
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: getQuizUI(), // Konten 'quiz' berada di sebelah kanan
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget getPRUI() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 32.0,
        crossAxisSpacing: 32.0,
        childAspectRatio: 0.8,
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
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 32.0,
        crossAxisSpacing: 32.0,
        childAspectRatio: 0.8,
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
        return CategoryView(
          callback: widget.callBack,
          category: category,
          animation: animation,
          animationController: animationController,
          onTap: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>  const PlayQuiz(),
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
    required this.onTap, // Tambahkan required untuk memastikan onTap tidak null
  }) : super(key: key);

  final VoidCallback? callback;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final VoidCallback onTap; // Gunakan tipe VoidCallback

  @override
  Widget build(BuildContext context) {
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
              onTap: onTap, // Panggil fungsi onTap di sini
              child: SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(105, 240, 155, 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                  color: DesignCourseAppTheme.notWhite),
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
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                          right: 16,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // const Text(
                                            //   'test',
                                            //   textAlign: TextAlign.left,
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.w200,
                                            //     fontSize: 12,
                                            //     letterSpacing: 0.27,
                                            //     color: DesignCourseAppTheme
                                            //         .grey,
                                            //   ),
                                            // ),
                                            // Container(
                                            //   child: const Row(
                                            //     children: <Widget>[
                                            //       Text(
                                            //         '',
                                            //         textAlign:
                                            //             TextAlign.left,
                                            //         style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.w200,
                                            //           fontSize: 18,
                                            //           letterSpacing: 0.27,
                                            //           color:
                                            //               DesignCourseAppTheme
                                            //                   .grey,
                                            //         ),
                                            //       ),
                                            //       // const Icon(
                                            //       //   Icons.star,
                                            //       //   color:
                                            //       //       DesignCourseAppTheme
                                            //       //           .nearlyBlue,
                                            //       //   size: 20,
                                            //       // ),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, right: 16, left: 16, bottom: 40),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color:
                                    DesignCourseAppTheme.grey.withOpacity(0.2),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 6.0),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: AspectRatio(
                              aspectRatio: 1.28,
                              child: Image.asset(category!.imagePath)),
                        ),
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
