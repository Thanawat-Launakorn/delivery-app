import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllProductResponseBody.dart';

class ProductItem extends StatelessWidget {
  final void Function() onPressed;
  
  final GetAllProductResponse product;
  const ProductItem(
      {required this.product, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(clipBehavior: Clip.none, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.image),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey[500]!, spreadRadius: 1)
                ],
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "\$${product.price}",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text(
                "${product.name}",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )
        ]),

        // GestureDetector(
        //   onTap: ,
        //   child: Positioned(
        //     right: -10,
        //     top: -10,
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: AppColors.colors['white'],
        //         borderRadius: BorderRadius.circular(12),
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.grey[400]!, spreadRadius: .5, blurRadius: 1.5)
        //         ],
        //       ),
        //       padding: const EdgeInsets.all(8),
        //       child: Icon(
        //         Icons.add,
        //         color: Theme.of(context).colorScheme.inversePrimary,
        //       ),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
