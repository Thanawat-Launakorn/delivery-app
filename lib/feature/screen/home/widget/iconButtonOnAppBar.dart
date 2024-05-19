import 'package:flutter/material.dart';

class IconButtonOnAppBar extends StatelessWidget {
  const IconButtonOnAppBar(
      {required this.onPress, required this.child, super.key});
  final Function() onPress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color.fromRGBO(255, 255, 255, .4)),
        child: child,
      ),
    );
  }
}
