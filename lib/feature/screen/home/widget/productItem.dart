import 'package:flutter/material.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/widget/colors.dart';

class ProductItem extends StatefulWidget {
  final int idx;
  const ProductItem({required this.idx, super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'productDetail');
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Asset.images["basket"] as String),
                    fit: BoxFit.contain),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey[500]!, spreadRadius: 1)],
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "\$2.99",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text(
                "Chocolate 80% ${widget.idx}",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )
        ]),
        Positioned(
          right: -10,
          top: -10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colors['white'],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!, spreadRadius: .5, blurRadius: 1.5)
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ]),
    );
  }
}
