import 'package:flutter/material.dart';

class CategoryAllScreen extends StatelessWidget {
  const CategoryAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หมวดหมู่สินค้า'),
      ),
      body: Center(child: Text('show all category')),
    );
  }
}
