import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';

// class UserProfilePage extends StatelessWidget {

//  final UserData userData;

//   UserProfilePage({required this.userData});

//   @override

//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text('User Profile'),
//   //     ),
//   //     body: Padding(
//   //       padding: const EdgeInsets.all(16.0),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           const CircleAvatar(
//   //             radius: 50,
//   //             backgroundImage: AssetImage('assets/design_course/userImage.png'), // Replace with your user's profile image
//   //           ),
//   //           const SizedBox(height: 16),
//   //           Text(
//   //           userData.values.nama,
//   //             style: const TextStyle(fontSize: 16),
//   //           ),
//   //           const SizedBox(height: 8),
//   //           Text(
//   //           userData.values.kelas,
//   //             style: const TextStyle(fontSize: 16),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }

class UserProfilePage extends StatelessWidget {
  final UserData userData;

  const UserProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    userData.values.nama,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     FloatingActionButton.extended(
                  //       onPressed: () {},
                  //       heroTag: 'follow',
                  //       elevation: 0,
                  //       label: const Text("Follow"),
                  //       icon: const Icon(Icons.person_add_alt_1),
                  //     ),
                  //     const SizedBox(width: 16.0),
                  //     FloatingActionButton.extended(
                  //       onPressed: () {},
                  //       heroTag: 'mesage',
                  //       elevation: 0,
                  //       backgroundColor: Colors.red,
                  //       label: const Text("Message"),
                  //       icon: const Icon(Icons.message_rounded),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  // const _ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _ProfileInfoRow extends StatelessWidget {
//    _ProfileInfoRow({Key? key}) : super(key: key);

//   // final List<ProfileInfoItem> _items = const [
//   //   ProfileInfoItem("Posts", 900),
//   //   ProfileInfoItem("Followers", 120),
//   //   ProfileInfoItem("Following", 200),
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       constraints: const BoxConstraints(maxWidth: 400),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: _items
//             .map((item) => Expanded(
//                     child: Row(
//                   children: [
//                     if (_items.indexOf(item) != 0) const VerticalDivider(),
//                     Expanded(child: _singleItem(context, item)),
//                   ],
//                 )))
//             .toList(),
//       ),
//     );
//   }

//   Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               item.value.toString(),
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           Text(
//             item.title,
//             style: Theme.of(context).textTheme.caption,
//           )
//         ],
//       );
// }

// class ProfileInfoItem {
//   final String title;
//   final int value;
//   const ProfileInfoItem(this.title, this.value);
// }

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xff0043ba), Color(0xff006df1)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    // color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/design_course/userImage.png'),
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: CircleAvatar(
                //     radius: 20,
                //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                //     child: Container(
                //       margin: const EdgeInsets.all(8.0),
                //       decoration: const BoxDecoration(
                //           color: Colors.green, shape: BoxShape.circle),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
