import 'package:dar_formazione/util/navigator.dart';
import 'package:dar_formazione/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../util/colors.dart';
import '../widget/footer.dart';
import 'category/category_screen.dart';
import 'demo/demo_screen.dart';
import 'info/info_screen.dart';
import 'webview_page/webview_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<void Function(BuildContext)> onTapActions;

  _HomePageScreenState()
      : onTapActions = [
          (context) {
            navPush(context, const DemoScreen());
          },
          (context) {
            navPush(context, const WebViewPage(url: 'https://drive.darpatenteapp.online/', title: 'QUIZ'));
          },
          (context) {
            navPush(context, const CategoryScreen());
          },
          (context) {
            navPush(context, const InfoScreen());
          },
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kcWhite,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColor.kcWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2.2, color: AppColor.kcPurple),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header(
                  context,
                  "Dar Formazione",
                  height: 76,
                  decoration: const BoxDecoration(
                    color: Color(0xff8080ff),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                const Gap(10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   crossAxisSpacing: 20,
                  //   mainAxisSpacing: 20,
                  // ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () => onTapActions[index](context),
                        child: demoLesson(index, context),
                      ),
                    );
                  },
                ),
                const Gap(32),
                footer(context, hasHome: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget demoLesson(int index, BuildContext context) {
    String name = index == 0
        ? 'DEMO'
        : index == 1
            ? 'QUIZ'
            : index == 2
                ? 'CATEGORY'
                : index == 3
                    ? 'INFO'
                    : '';
    return header(context, name, showImage: false);
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 80,
    //   decoration: BoxDecoration(
    //     color: Colors.transparent,
    //     // image: const DecorationImage(image: AssetImage('assets/pixelcut-export.png')),
    //     borderRadius: BorderRadius.circular(14),
    //   ),
    //   alignment: Alignment.center,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
    //     child: FittedBox(
    //       child: Text(
    //         name,
    //         style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   ),
    // );
  }
}
