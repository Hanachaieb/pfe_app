import 'package:flutter/material.dart';

class SplashedIcon extends StatelessWidget {
  final Widget child;

  final Color color;
  final Color highlightColor;
  final VoidCallback onPressed;
  const SplashedIcon({Key? key, required this.color, required this.child, required this.highlightColor, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
          onTap: () => onPressed(),
          highlightColor: highlightColor,
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: child,
          )),
    );
  }
}
