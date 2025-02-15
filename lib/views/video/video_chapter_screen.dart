import 'dart:convert';

import 'package:dar_formazione/util/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/video.dart';
import '../../../util/colors.dart';
import '../../../util/url.dart';
import '../../util/navigator.dart';
import '../../widget/footer.dart';
import '../../widget/header.dart';
import 'video_screen.dart';

class VideoChapterScreen extends StatefulWidget {
  final String videoId;

  const VideoChapterScreen({super.key, required this.videoId});

  @override
  State<VideoChapterScreen> createState() => _VideoChapterScreenState();
}

class _VideoChapterScreenState extends State<VideoChapterScreen> {
  bool loader = true;
  dynamic userToken;
  final List<VideoModel> _video = [];

  getShare() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    getCategoryApi();
  }

  getCategoryApi() async {
    try {
      http.Response response = await http.get(Uri.parse(AppUrl.videoUrl + widget.videoId), headers: {"Authorization": "Bearer $userToken"});

      Map jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < jsonData['data'].length; i++) {
          Map<String, dynamic> object = jsonData['data'][i];
          VideoModel test = VideoModel();
          test = VideoModel.fromJson(object);
          _video.add(test);
        }
      } else {
        showSnackMessage(context, 'Something went wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('_VideoChapterScreenState.getCategoryApi::: $e');
      }
    }
    setState(() {
      loader = false;
    });
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
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2.2, color: AppColor.kcPurple),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: loader
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      header(
                        context,
                        "Videos",
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
          ),
        ),
      ),
    );
  }

  Widget demoLesson() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _video.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            navPush(
                context,
                VidePlayScreen(
                  name: _video[index].name ?? '',
                  video: _video[index].videoWithLink ?? '',
                  thumbnail: _video[index].cat?.image ?? '',
                  videoId: _video[index].id?.toString() ?? '',
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: header(context, _video[index].name ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
