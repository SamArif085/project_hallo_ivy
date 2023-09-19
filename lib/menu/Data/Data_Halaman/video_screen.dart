import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'Color_Theme.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import 'models/refreshdata.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    required this.materi,
  }) : super(key: key);
  final Map<String, dynamic> materi;
  @override
  // ignore: library_private_types_in_public_api
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  late FlickManager flickManager;
  int _playCount = 0;
  final double infoHeight = 364.0;
  bool _isPlaying = false;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void dispose() {
    flickManager.dispose(); // Menghentikan pemutar video
    animationController?.dispose(); // Membebaskan sumber daya animasi
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
    UserDataManager.refreshUserData();
    var controller = VideoPlayerController.network(
      widget.materi['link_materi'],
    );

    flickManager = FlickManager(
      videoPlayerController: controller,
      autoPlay: false,
    );
    controller.addListener(() {
      if (controller.value.position >=
              controller.value.duration - const Duration(seconds: 2) &&
          controller.value.position < controller.value.duration) {
        if (!_isPlaying) {
          setState(() {
            _playCount++;
            _isPlaying = true;
            // Perhitungan data cout db dan data count sekarang
            widget.materi['count'] =
                (_playCount + int.parse(widget.materi['count'])).toString();
            // Fungsi Paramteri pada server
            Map<String, dynamic> postData = {
              'count_video': widget.materi['count'],
              'nisn': widget.materi['nisn'],
              'id_materi': widget.materi['id'],
            };
            // Kirim permintaan POST ke server
            http
                .post(
              Uri.parse('https://hello-ivy.id/post_count.php'),
              body: postData,
            )
                .then((response) {
              if (response.statusCode == 200) {
                print('Data count berhasil dikirim');
              } else {
                print('Gagal mengirim data count');
              }
            }).catchError((error) {
              print('Terjadi kesalahan saat mengirim permintaan POST: $error');
            });
          });
        }
      } else {
        _isPlaying = false;
      }
    });
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.4,
                  child: SizedBox(
                    child: VisibilityDetector(
                      key: ObjectKey(flickManager),
                      onVisibilityChanged: (visibility) {
                        if (visibility.visibleFraction == 0 && this.mounted) {
                          flickManager.flickControlManager?.autoPause();
                        } else if (visibility.visibleFraction == 1) {
                          flickManager.flickControlManager?.autoResume();
                          setState(() {
                            // _playCount++;
                          });
                        }
                      },
                      child: FlickVideoPlayer(
                        flickManager: flickManager,
                        flickVideoWithControls: const FlickVideoWithControls(
                          closedCaptionTextStyle: TextStyle(fontSize: 8),
                          controls: FlickPortraitControls(),
                        ),
                        flickVideoWithControlsFullscreen:
                            const FlickVideoWithControls(
                          controls: FlickLandscapeControls(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.4) - 0.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 18, right: 16),
                            child: Text(
                              widget.materi['judul_materi'],
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                          Container(
                            // top: (MediaQuery.of(context).size.width / 1.1) - 20.0 - 25,
                            // left: 0,
                            // padding: EdgeInsets.all(20),
                            child: ScaleTransition(
                              alignment: Alignment.center,
                              scale: CurvedAnimation(
                                  parent: animationController!,
                                  curve: Curves.fastOutSlowIn),
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: <Widget>[
                                      getTimeBoxUI('Diputar sebanyak',
                                          widget.materi['count']),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8),
                                child: Container(
                                  height: 300,
                                  child: SfCartesianChart(
                                    primaryXAxis:
                                        CategoryAxis(), // Menggunakan axis kategori di sumbu X
                                    primaryYAxis:
                                        NumericAxis(), // Menggunakan axis numerik di sumbu Y
                                    series: <ChartSeries>[
                                      ColumnSeries<Map, String>(
                                        color: HexColor('#85f29d'),
                                        dataSource: [
                                        {'x': 'Diputar', 'y': int.parse(widget.materi['count'])},
                                          // Tambahkan data lainnya sesuai kebutuhan
                                        ],
                                        xValueMapper: (Map data, int index) =>
                                            data['x'],
                                        yValueMapper: (Map data, int index) =>
                                            data['y'],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.1) - 20.0 - 25,
              right: 0,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController!, curve: Curves.fastOutSlowIn),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity1,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        // quiz('Quiz', () {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           HomePage(userData: widget.userData),
                        //     ),
                        //   );
                        // }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlack,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              const SizedBox(
                width: 10,
                child: Text(':'),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget quiz(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: HexColor('#85f29d'),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 12.0,
              bottom: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.nearlyBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
