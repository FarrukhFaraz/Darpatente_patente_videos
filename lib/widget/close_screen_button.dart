import 'package:flutter/material.dart';

class CloseScreenButton extends StatelessWidget {
  const CloseScreenButton({this.color = Colors.white, this.hasBoxShadow = true, this.bgColor, this.onTap, this.size = 20,this.padding, super.key});
  final Color color;
  final Color? bgColor;
  final double size;
  final bool hasBoxShadow;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? Colors.black.withOpacity(0.3),
          boxShadow: hasBoxShadow
              ? [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: bgColor ?? Colors.black.withOpacity(0.25),
                  ),
                ]
              : null,
        ),
        padding:padding ?? const EdgeInsets.all(4),
        child: Icon(Icons.clear, color: color, size: size),
      ),
    );
  }
}
