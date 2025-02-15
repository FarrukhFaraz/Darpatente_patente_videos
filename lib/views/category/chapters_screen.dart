import 'package:dar_formazione/util/navigator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../util/colors.dart';
import '../../model/chapter.dart';
import '../../widget/footer.dart';
import '../../widget/header.dart';
import '../video/video_chapter_screen.dart';

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key, required this.chapters});

  final List<ChaptersModel> chapters;

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
            child: Column(
              children: [
                header(
                  context,
                  "Chapters",
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
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        ChaptersModel model = chapters[index];
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => navPush(context, VideoChapterScreen(videoId: model.chapterId.toString())),
            child: header(context, model.chapter?.name ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
