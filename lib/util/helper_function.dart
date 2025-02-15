// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
//
// class HelperFunction {
//   HelperFunction._();
//
//   static BetterPlayerController initVideoPlayer(
//       {required String url,
//       context,
//       required double? aspectRatio,
//       required bool autoPlay,
//       bool showControls = false,
//       bool? autoDispose,
//       bool? isHls,
//       Widget? loadingWidget,
//       BoxFit? fit}) {
//     BetterPlayerController betterPlayerController;
//     betterPlayerController = BetterPlayerController(
//         BetterPlayerConfiguration(
//           fit: fit ?? BoxFit.fitWidth,
//           aspectRatio: aspectRatio,
//           autoDispose: autoDispose ?? false,
//           autoPlay: autoPlay,
//           looping: true,
//           handleLifecycle: false,
//           fullScreenByDefault: false,
//           expandToFill: false,
//           showPlaceholderUntilPlay: true,
//           controlsConfiguration: BetterPlayerControlsConfiguration(
//               showControls: true,
//               enableAudioTracks: false,
//               enableFullscreen: false,
//               enableMute: false,
//               enableProgressBar: false,
//               enableOverflowMenu: false,
//               enableProgressBarDrag: false,
//               enableQualities: false,
//               enablePip: false,
//               enablePlaybackSpeed: false,
//               enablePlayPause: false,
//               enableProgressText: false,
//               enableRetry: false,
//               enableSkips: false,
//               enableSubtitles: false,
//               controlBarColor: Colors.transparent,
//               loadingWidget: loadingWidget),
//         ),
//         betterPlayerDataSource: BetterPlayerDataSource.network(
//           url,
//           cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//           videoFormat: isHls == true ? BetterPlayerVideoFormat.hls : null,
//           bufferingConfiguration: const BetterPlayerBufferingConfiguration(
//             minBufferMs: 2000, // Minimum buffer before playback (2 sec)
//             maxBufferMs: 60000, // Maximum buffer allowed (60 sec)
//             bufferForPlaybackMs: 1500, // Buffer required before playback (3 sec)
//             bufferForPlaybackAfterRebufferMs: 5000, // Buffer required after rebuffering (5 sec)
//           ),
//         ));
//     return betterPlayerController;
//   }
// }
