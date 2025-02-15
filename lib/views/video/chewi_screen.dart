import 'package:chewie/chewie.dart';
import 'package:dar_formazione/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ChewiScreen extends StatefulWidget {
  final String video;
  final String title;

  const ChewiScreen({
    super.key,
    required this.video,
    required this.title,
  });

  @override
  State<ChewiScreen> createState() => _ChewieScreenState();
}

class _ChewieScreenState extends State<ChewiScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _init();
  }

  _init() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.video));

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      allowFullScreen: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      showOptions: true,
      showControlsOnInitialize: false,
      fullScreenByDefault: false,
      showControls: true,
      draggableProgressBar: true,
      placeholder: const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, msg) {
        return Center(
          child: Tooltip(
            triggerMode: TooltipTriggerMode.longPress,
            message: msg,
            child: const Icon(Icons.error, color: Colors.white, size: 50),
          ),
        );
      },
    );

    _chewieController!.addListener(() {
      if (_chewieController!.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kcBlack,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: AppColor.kcWhite),
        ),
        title: Text(widget.title.toString(), style: TextStyle(color: AppColor.kcWhite)),
      ),
      backgroundColor: AppColor.kcBlack,
      body: SafeArea(
        child: _chewieController == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Chewie(controller: _chewieController!),
                ],
              ),
      ),
    );
  }
}
