import 'package:flutter/cupertino.dart';

import '../util/colors.dart';

Widget header(
  BuildContext context,
  String title, {
  bool showImage = true,
  Color? backgroundColor,
  double? radius,
  BoxBorder? border,
  BoxDecoration? decoration,
  double? height,
}) {
  return Container(
    height: height ?? 66,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: decoration ??
        BoxDecoration(
          color: backgroundColor ?? const Color(0xff8080ff),
          borderRadius: BorderRadius.circular(radius ?? 20),
          border: border,
        ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, color: AppColor.kcWhite, fontWeight: FontWeight.w500),
        ),
        if (showImage)
          Positioned(
            right: 10,
            child: Image(
              image: const AssetImage("assets/logo2.jpeg"),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
      ],
    ),
  );
}
