import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/feature/screen/home/widget/productItem.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/widget/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final content = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colors['white'],
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(hintText: translations(context)!.search),
        ),
      ),
      body: Center(
        child: GridView.builder(
          itemCount: 4,
          primary: false,
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 24),
          itemBuilder: (context, index) {
            return ProductItem(idx: index,);
          },
        ),
      ),
    );
  }
}
