import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/VideoApp2.dart';

class VideoApp3 extends StatelessWidget {
  const VideoApp3({super.key});
  static String tag = 'konten-page-video-3';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: SizedBox(
              height: 500,
              width: 500,
              child: VideoApp2(),
            ),
          ),
        ],
      ),
    );
  }
}
