class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    // this.lessonCount = 0,
    // this.money = 0,
    // this.rating = 0.0,
  });

  String title;
  // int lessonCount;
  // int money;
  // double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/materi1.png',
      title: 'Materi Tema 1',
      // lessonCount: 24,
      // money: 25,
      // rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      // lessonCount: 22,
      // money: 18,
      // rating: 4.6,
    ),
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      // lessonCount: 24,
      // money: 25,
      // rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      // lessonCount: 22,
      // money: 18,
      // rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Tugas Rumah',
      // lessonCount: 12,
      // money: 25,
      // rating: 4.8,
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Quiz',
      // lessonCount: 28,
      // money: 208,
      // rating: 4.9,
    ),
  ];

    static List<Category> gameList = <Category>[
    Category(
      imagePath: 'assets/susun_kata.png',
      title: 'Susun Kata',
      // lessonCount: 24,
      // money: 25,
      // rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      // lessonCount: 22,
      // money: 18,
      // rating: 4.6,
    ),
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      // lessonCount: 24,
      // money: 25,
      // rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      // lessonCount: 22,
      // money: 18,
      // rating: 4.6,
    ),
  ];
}
