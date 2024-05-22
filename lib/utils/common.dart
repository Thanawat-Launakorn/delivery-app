import 'package:flutter/material.dart';

void onNavigateToScreen(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void onReplaceToScreen(BuildContext context, String routeName) {
  Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
}