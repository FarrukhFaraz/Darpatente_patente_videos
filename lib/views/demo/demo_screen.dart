import 'dart:convert';

import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/widget/footer.dart';
import 'package:dar_formazione/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../model/demo_cat.dart';
import '../../../util/colors.dart';
import '../../../util/url.dart';
import 'demo_chapter_screen.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  dynamic userToken;
  bool loader = true;
  List<DemoCategoryModel> _getDemoCategory = [];

  @override
  void initState() {
    super.initState();
    demoCatApi();
  }

  Future<void> demoCatApi() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.demoUrl),
        headers: {"Authorization": "Bearer $userToken"},
      );

      if (response.statusCode == 200) {
        final Map jsonData = jsonDecode(response.body);
        setState(() {
          loader = false;
          _getDemoCategory = List<DemoCategoryModel>.from(jsonData['data'].map((item) => DemoCategoryModel.fromJson(item)));
        });
      } else {
        setState(() {
          loader = false;
        });
      }
    } catch (e) {
      setState(() {
        loader = false;
      });
    }
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
      itemCount: _getDemoCategory.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => navPush(context, DemoChapterScreen(id: _getDemoCategory[index].id.toString())),
            child: header(context, _getDemoCategory[index].name ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
