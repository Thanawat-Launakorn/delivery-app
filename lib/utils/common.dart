import 'package:flutter/material.dart';

void onNavigateToScreen(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void onReplaceToScreen(BuildContext context, String routeName) {
  Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
}

String capitalize(String s) {
  if (s.isEmpty) return s;

  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
