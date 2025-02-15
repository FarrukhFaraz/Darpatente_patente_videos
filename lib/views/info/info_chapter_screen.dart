import 'dart:convert';

import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/views/webview_page/webview_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../model/info_chapter.dart';
import '../../../util/colors.dart';
import '../../../util/url.dart';
import '../../widget/footer.dart';
import '../../widget/header.dart';

class InfoChapterScreen extends StatefulWidget {
  final String id;

  const InfoChapterScreen({super.key, required this.id});

  @override
  State<InfoChapterScreen> createState() => _InfoChapterScreenState();
}

class _InfoChapterScreenState extends State<InfoChapterScreen> {
  dynamic userToken;
  bool loader = true;
  final List<InfoChapterModel> _getInfoChapter = [];

  getDemoChapterApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse(AppUrl.getInfoChapterUrl + widget.id),
        headers: {"Authorization": "Bearer $userToken"},
      );

      print('_InfoChapterScreenState.getDemoChapterApi::: ${AppUrl.getInfoChapterUrl + widget.id}');

      Map jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (int i = 0; i < jsonData['data'].length; i++) {
          Map<String, dynamic> object = jsonData['data'][i];
          InfoChapterModel test = InfoChapterModel();
          test = InfoChapterModel.fromJson(object);
          _getInfoChapter.add(test);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('_InfoChapterScreenState.getDemoChapterApi::: $e');
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
                        "Videos",
                        height: 76,
                        decoration: const BoxDecoration(
                          color: Color(0xff8080ff),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                      ),
                      const Gap(10),
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
    if (_getInfoChapter.isEmpty) {
      return Center(
        child: Text(
          'No data found',
          style: TextStyle(fontSize: 24, color: AppColor.kcBlue, fontWeight: FontWeight.w400),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _getInfoChapter.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            String? url = _getInfoChapter[index].link;
            if (url != null) {
              navPush(context, WebViewPage(title: _getInfoChapter[index].name ?? '', url: url));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: header(context, _getInfoChapter[index].name ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
