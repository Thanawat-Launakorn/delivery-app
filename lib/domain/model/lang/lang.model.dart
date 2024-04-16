import 'dart:ui';

import 'package:flutter/material.dart';

enum LanguageApp {
  eng,
  thai
}

class LanguageModel {
  final Locale local;
  final Widget flag;
  final String text;

  LanguageModel({ required this.local, required this.flag, required this.text });
}