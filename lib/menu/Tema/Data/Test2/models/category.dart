class Category {
  Category({
    this.title = '',
    this.imagePath = '',
  });

  String title;

  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Materi Tema',
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Quiz',
    ), 
  ];

    static List<Category> testcourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Tugas Rumah',
    ),
  ];

   static List<Category> prcourseList = <Category>[
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
  ];
      static List<Category> game1List = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'Susun Kata2',

    ),
  ];
}
