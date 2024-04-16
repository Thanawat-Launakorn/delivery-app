import 'package:flutter/material.dart';

class Menu {

  const Menu({
    required this.id,
    required this.title,
    required this.page,
  });

  final int id;
  final String title;
  final void Function() page;
}