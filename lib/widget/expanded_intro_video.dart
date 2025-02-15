// import 'package:better_player/better_player.dart';
// import 'package:dar_formazione/util/colors.dart';
// import 'package:flutter/material.dart';
//
// import '../util/helper_function.dart';
// import 'close_screen_button.dart';
//
// class ExpandedIntroVideo extends StatefulWidget {
//   const ExpandedIntroVideo({required this.url, super.key});
//   final String url;
//
//   @override
//   State<ExpandedIntroVideo> createState() => _ExpandedIntroVideoState();
// }
//
// class _ExpandedIntroVideoState extends State<ExpandedIntroVideo> {
//   BetterPlayerController? betterPlayerController;
//   @override
//   void initState() {
//     betterPlayerController = HelperFunction.initVideoPlayer(
//       url: widget.url,
//       aspectRatio: null,
//       fit: BoxFit.fill,
//       autoPlay: true,
//       autoDispose: true,
//     );
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   dispose() {
//     super.dispose();
//     betterPlayerController?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.kcBlack,
//       body: Stack(
//         children: [
//           _buildVideoPage(widget.url),
//           Positioned(
//             top: 10,
//             left: 0,
//             child: _appBar(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _appBar() {
//     return Padding(
//       padding: EdgeInsets.only(left: 15, top: MediaQuery.of(context).viewPadding.top + 10, right: 15),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const SizedBox(),
//           CloseScreenButton(
//             size: 15,
//             padding: const EdgeInsets.all(5),
//             bgColor: Colors.black.withOpacity(0.10),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildVideoPage(String mediaUrl) {
//     if (betterPlayerController?.videoPlayerController?.value.initialized ?? true) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return BetterPlayer(controller: betterPlayerController!);
//   }
// }
