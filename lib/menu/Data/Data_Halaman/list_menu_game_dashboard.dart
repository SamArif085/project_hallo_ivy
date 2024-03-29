import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_Theme.dart';
import 'models/materi_category.dart';

class GameListView extends StatefulWidget {
  const GameListView({Key? key, this.callBack}) : super(key: key);

  final void Function(Category2 category)? callBack;
  @override
  _GameListViewState createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  int? _selectedCategoryIndex; // Variable to track the selected card index

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<List<Category2>> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      List<Map<String, dynamic>> materiList =
          userData['link_game'].cast<Map<String, dynamic>>();

      List<Category2> categories =
          materiList.map((map) => Category2.fromMap(map)).toList();
      return categories;
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 140,
        width: double.infinity,
        child: FutureBuilder<List<Category2>>(
          future: getData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category2>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              List<Category2> categoryList1 = snapshot.data!;
              return ListView.builder(
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
                itemCount: categoryList1.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = categoryList1.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return Category2View(
                    category: categoryList1[index],
                    animation: animation,
                    animationController: animationController,
                    isSelected: _selectedCategoryIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                      widget.callBack!(categoryList1[index]);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class Category2View extends StatelessWidget {
  const Category2View({
    Key? key,
    this.category,
    this.animationController,
    this.animation,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final Category2? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double sizedPad = MediaQuery.of(context).size.width > 600 ? 95 : 30;
    double widtFac = MediaQuery.of(context).size.width > 600 ? 0.7 : 0.8;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: onTap,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 78,
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.yellowAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Row(
                              children: <Widget>[
                                // const SizedBox(
                                //   width: 60,
                                // ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(sizedPad, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        FractionallySizedBox(
                                          widthFactor: widtFac,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Text(
                                              category?.title1 ?? '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // const Expanded(
                                        //   child: SizedBox(),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: DesignCourseAppTheme
                                                    .nearlyWhite,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: DesignCourseAppTheme
                                                      .nearlyGreen,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    // Conditionally show the image based on selection
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: ClipRRect(
                              // aspectRatio: 1.0,
                              borderRadius: BorderRadius.circular(10.0),
                              child: category != null
                                  ? Image.network(category!
                                      .imagePath1) // Use Image.network for server images
                                  : const SizedBox(),
                            ),
                          )
                        ],
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
