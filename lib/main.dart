import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/a.mp4',
    )..initialize().then((_) {
        _controller!.setLooping(true);
        _controller!.play();
        _controller!.setPlaybackSpeed(0.4);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _controller!.value.isInitialized
                  ? SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: VideoPlayer(_controller!),
                    )
                  : Container(),
              Positioned.fill(
                child: Container(
                  color: Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu),
                          CircleAvatar(child: Icon(Icons.add))
                        ],
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abeokuta South',
                              style: textStyle.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              'Sun, October 22 4:00 PM',
                              style: textStyle.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 70),
                            Center(
                              child: Column(
                                children: [
                                  const FlutterLogo(size: 120),
                                  const SizedBox(height: 30),
                                  Text(
                                    'Mostly Cloudy',
                                    style: textStyle.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,height: 1.6),
                                  ),
                                  Text(
                                    '84°/73°',
                                    style: textStyle.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,height: 1.6),
                                  ),
                                  Text(
                                    'Feels like 90°',
                                    style: textStyle.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
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
            ],
          );
        },
      ),
    );
  }
}
