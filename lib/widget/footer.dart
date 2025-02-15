import 'package:flutter/material.dart';

import '../util/colors.dart';

Widget footer(BuildContext context, {bool hasHome = true}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (hasHome)
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.home, size: 40),
        ),
      Divider(color: AppColor.kcBlue, height: 5, thickness: 2, indent: 16, endIndent: 16),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Text(
            "Dar formazione per patente e lingue italiana\npatente AM, B, C, D, Corse CQC,\ninfo. 3779870452",
            style: TextStyle(fontSize: 14, color: AppColor.kcBlack, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}
