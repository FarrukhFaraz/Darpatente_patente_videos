import 'dart:convert';

import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/util/show_message.dart';
import 'package:dar_formazione/widget/footer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/colors.dart';
import '../../../util/url.dart';
import '../../model/chapter.dart';
import '../../widget/header.dart';
import 'chapters_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool loader = true;
  dynamic userToken;
  dynamic categoryName;
  final List<ChaptersModel> _chapters = [];

  getShare() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    getCategoryApi();
  }

  getCategoryApi() async {
    try {
      http.Response response = await http.get(Uri.parse(AppUrl.userInfoUrl), headers: {"Authorization": "Bearer $userToken"});
      Map jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        categoryName = jsonData['data']['category']['name'];
        for (int i = 0; i < jsonData['data']["chapters"].length; i++) {
          Map<String, dynamic> object = jsonData['data']["chapters"][i];
          ChaptersModel test = ChaptersModel();
          test = ChaptersModel.fromJson(object);
          _chapters.add(test);
        }
      } else {
        showSnackMessage(context, 'Something went wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('_CategoryScreenState.getCategoryApi:::: $e');
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
                        "Category",
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
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => navPush(context, ChapterScreen(chapters: _chapters)),
            child: header(context, categoryName ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
