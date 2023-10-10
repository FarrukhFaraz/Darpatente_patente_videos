import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Utils/colors.dart';

class VideoPassScreen extends StatefulWidget {
  final String appbar;
  final String videoplay;
  const VideoPassScreen({
    super.key,
    required this.appbar,
    required this.videoplay,
  });

  @override
  State<VideoPassScreen> createState() => _VideoPassScreenState();
}

class _VideoPassScreenState extends State<VideoPassScreen> {
  bool loader = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoplay.toString(),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          // loader = true;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: yellow800,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(widget.appbar),
      ),
      body: loader
          ? Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  // leftDotColor: const Color(0xFF1A1A3F),
                  // rightDotColor: const Color(0xFFEA3799),
                  color: kBlack,
                  size: 40),
            )
          : Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
                  // alignment: Alignment.center,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.18,
                  left: MediaQuery.of(context).size.width * 0.44,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: kWhite,
                        size: 40,
                      )),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
