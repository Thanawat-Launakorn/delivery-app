// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AppButtonSize { SMALL, MEDIUM, LARGE }

enum AppButtonState { DEFAULT, DISABLED }

enum AppButtonType { PRIMARY, SECONDARY }

enum AppButtonBorder { FLAT, SEMIROUNDED, ROUNDED }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.marginTop = 0,
    required this.text,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    required this.onPressed,
    this.size = AppButtonSize.MEDIUM,
    this.type = AppButtonType.PRIMARY,
    this.state = AppButtonState.DEFAULT,
    this.border = AppButtonBorder.SEMIROUNDED,
  });

  final String text;
  final Widget? leftIcon;
  final double marginTop;
  final Widget? rightIcon;
  final double marginLeft;
  final AppButtonSize size;
  final AppButtonType type;
  final double marginRight;
  final double marginBottom;
  final AppButtonState state;
  final AppButtonBorder border;
  final void Function() onPressed;

  TextStyle? displayText(BuildContext context) {
    switch (size) {
      case AppButtonSize.LARGE:
        return Theme.of(context).textTheme.titleLarge;
      case AppButtonSize.MEDIUM:
        return Theme.of(context).textTheme.titleMedium;
      case AppButtonSize.SMALL:
        return Theme.of(context).textTheme.titleSmall;
    }
  }

  OutlinedBorder? displayBorder() {
    switch (border) {
      case AppButtonBorder.FLAT:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
      case AppButtonBorder.SEMIROUNDED:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
      case AppButtonBorder.ROUNDED:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
    }
  }

  EdgeInsetsGeometry? displayPadding() {
    switch (size) {
      case AppButtonSize.LARGE:
        return const EdgeInsets.all(16);
      case AppButtonSize.MEDIUM:
        return const EdgeInsets.all(10);

      case AppButtonSize.SMALL:
        return const EdgeInsets.all(6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Theme.of(context).colorScheme.inversePrimary;
    return Container(
      padding:
          EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: state == AppButtonState.DISABLED ? null : onPressed,
          style: ElevatedButton.styleFrom(
              textStyle: displayText(context),
              backgroundColor:
                  state == AppButtonState.DISABLED ? Colors.grey : defaultColor,
              padding: displayPadding(),
              shape: displayBorder()),
          child: Text(text)),
    );
  }
}
