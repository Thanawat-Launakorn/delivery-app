import 'package:flutter/material.dart';
import 'package:flutter_application_1/route/app_arguments.dart';

class CategoryDetailScreen extends StatelessWidget {
  final CategoryDetailArguments arguments;
  const CategoryDetailScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Detail'),
      ),
    );
  }
}
