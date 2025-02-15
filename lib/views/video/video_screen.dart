import 'dart:convert';

import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/util/url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/colors.dart';
import '../../util/show_message.dart';
import '../../widget/footer.dart';
import '../../widget/header.dart';
import 'chewi_screen.dart';

class VidePlayScreen extends StatefulWidget {
  final String name;
  final String video;
  final String thumbnail;
  final String videoId;

  const VidePlayScreen({
    super.key,
    required this.name,
    required this.video,
    required this.thumbnail,
    required this.videoId,
  });

  @override
  State<VidePlayScreen> createState() => _VidePlayScreenState();
}

class _VidePlayScreenState extends State<VidePlayScreen> {
  bool loader = false;
  dynamic userToken;

  userVideoHistoryAPI(BuildContext context) async {
    setState(() {
      loader = true;
    });

    Map<String, String> body = {'video_id': widget.videoId};
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Accept": "application/json",
    };

    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.userVideoHistoryUrl),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'success') {
          if (context.mounted) {
            navPush(context, ChewiScreen(title: widget.name, video: widget.video));
            // navPush(context,  ExpandedIntroVideo(url: widget.video));
            showSnackMessage(context, jsonData['message']);
          }
        } else {
          if (context.mounted) showSnackMessage(context, 'Failed to log video history');
        }
      } else {
        if (context.mounted) showSnackMessage(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('_VidePlayScreenState.userVideoHistoryAPI:::: $e');
      }
      if (context.mounted) showSnackMessage(context, 'An error occurred');
    }
    setState(() {
      loader = false;
    });
  }

  getShare() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
  }

  @override
  void initState() {
    super.initState();
    getShare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kcWhite,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 2.2, color: AppColor.kcPurple),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  header(
                    context,
                    widget.name,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: Color(0xff8080ff),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    ),
                  ),
                  const Gap(6),
                  Expanded(child: demoLesson()),
                  footer(context),
                ],
              ),
              loader
                  ? Container(
                      color: Colors.grey.withOpacity(0.1),
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget demoLesson() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Image.asset(
            'assets/logo2.jpeg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.video.isNotEmpty) {
              userVideoHistoryAPI(context);
            } else {
              showSnackErrorMessage(context, 'No Video Available', 3);
            }
          },
          child: Icon(Icons.play_arrow, size: 100, color: AppColor.kcBlack),
        )
      ],
    );
  }
}
