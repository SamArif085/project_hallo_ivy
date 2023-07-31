class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.pageToMove = '',
 
  });

  String title;
  String pageToMove;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Materi Tema 1',
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Tugas Rumah',
      pageToMove: 'game',

    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Quiz',
      pageToMove: 'quiz',

    ), 
  ];

   static List<Category> PRCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Tugas Rumah',
    ),
  ];

    static List<Category> gameList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Susun Kata',

    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
  
    ),
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',

    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',

    ),
  ];
}
