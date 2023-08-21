import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_Theme.dart';
import 'models/materi_category.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key, this.callBack}) : super(key: key);

    final void Function(Category category)? callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
 int? _selectedCategoryIndex; 
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<List<Category>> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      List<Map<String, dynamic>> materiList =
          userData['values']['materi_user'].cast<Map<String, dynamic>>();

      List<Category> categories =
          materiList.map((map) => Category.fromMap(map)).toList();
      return categories;
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 140,
        width: double.infinity,
        child: FutureBuilder<List<Category>>(
          future: getData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              List<Category> categoryList = snapshot.data!;
              return ListView.builder(
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = categoryList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return CategoryView(
                    category: categoryList[index],
                    animation: animation,
                    animationController: animationController,
                    isSelected: _selectedCategoryIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                      widget.callBack!(categoryList[index]);
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

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      required this.isSelected,
      required this.onTap,
      })
      : super(key: key);

final bool isSelected;
  final VoidCallback onTap;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.91,
                // height: MediaQuery.of(context).size.height * 0.9,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(105, 240, 155, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Text(
                                              category?.title ?? '',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Text(
                                                  '',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: const Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 18,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                      // Icon(
                                                      //   Icons.star,
                                                      //   color:
                                                      //       DesignCourseAppTheme
                                                      //           .nearlyBlue,
                                                      //   size: 20,
                                                      // ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, right: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  '',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .nearlyBlue,
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: DesignCourseAppTheme
                                                        .notWhite,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                      Icons.bookmark,
                                                      color: Colors.greenAccent,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
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
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 24, left: 16),
                        child: Row(
                          children: <Widget>[
                          ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: category != null
                              ? Image.network(category!.imagePath) // Use Image.network for server images
                              : SizedBox(),
                        ),
                      ),
                          ],
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
