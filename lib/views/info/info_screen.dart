import 'dart:convert';

import 'package:dar_formazione/util/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../../model/info.dart';
import '../../../util/colors.dart';
import '../../../util/url.dart';
import '../../widget/footer.dart';
import '../../widget/header.dart';
import 'info_chapter_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  dynamic userToken;
  bool loader = true;
  final List<InfoModel> _getInfoCategory = [];

  demoCatApi() async {
    try {
      http.Response response = await http.get(Uri.parse(AppUrl.infoUrl), headers: {"Authorization": "Bearer $userToken"});

      Map jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < jsonData['data'].length; i++) {
          Map<String, dynamic> object = jsonData['data'][i];
          InfoModel test = InfoModel();
          test = InfoModel.fromJson(object);
          _getInfoCategory.add(test);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('_InfoScreenState.demoCatApi:::: $e');
      }
    }
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    super.initState();
    demoCatApi();
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
      itemCount: _getInfoCategory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            navPush(context, InfoChapterScreen(id: _getInfoCategory[index].id?.toString() ?? ''));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: header(context, _getInfoCategory[index].name ?? '', showImage: false),
          ),
        );
      },
    );
  }
}
