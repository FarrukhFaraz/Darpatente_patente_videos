import 'dart:convert';

import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/views/webview_page/webview_page.dart';
import 'package:dar_formazione/widget/footer.dart';
import 'package:dar_formazione/widget/header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../model/demo_chapter.dart';
import '../../../util/colors.dart';
import '../../../util/url.dart';

class DemoChapterScreen extends StatefulWidget {
  final String id;

  const DemoChapterScreen({
    super.key,
    required this.id,
  });

  @override
  State<DemoChapterScreen> createState() => _DemoChapterScreenState();
}

class _DemoChapterScreenState extends State<DemoChapterScreen> {
  dynamic userToken;
  bool loader = true;
  final List<DemoChapter> _getDemoChapter = [];

  getDemoChapterApi() async {
    try {
      http.Response response = await http.get(Uri.parse(AppUrl.getDemoChapterUrl + widget.id), headers: {"Authorization": "Bearer $userToken"});

      Map jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (int i = 0; i < jsonData['data'].length; i++) {
          Map<String, dynamic> object = jsonData['data'][i];
          DemoChapter test = DemoChapter();
          test = DemoChapter.fromJson(object);
          _getDemoChapter.add(test);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('_DemoChapterScreenState.getDemoChapterApi::: $e');
      }
    }
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDemoChapterApi();
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
                        "Demo",
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
      itemCount: _getDemoChapter.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              navPush(context, WebViewPage(title: _getDemoChapter[index].name ?? '', url: '${_getDemoChapter[index].link}'));
            },
            child: header(context, _getDemoChapter[index].name ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
