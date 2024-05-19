import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/widget/colors.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var isAdd = false;

  void isOnAdd() {
    setState(() {
      isAdd = true;
    });
  }

  Widget amountButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.colors['white'],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                )
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          width: 65,
          height: 50,
          child:  Icon(
            Icons.remove,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 24,
          ),
        ),
        Container(
          width: 65,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary),
          child: Center(
              child: Text(
            '1',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.colors['white']),
          )),
        ),
        Container(
          width: 65,
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.colors['white'],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                )
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product Details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: const [Icon(Icons.favorite_outline)],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        Asset.images['basket'] as String))),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  '\$0.99',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 24,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary),
                                ),
                                Text(
                                  'Eti Browni Intense',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      'Soft moist cake, intense chocolate and delicious chocolate coating… You never know when and under what conditions the Browni Intense Crisis will come… What happens, what happens; there is too much somewhere.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: isAdd
                    ? amountButton(context)
                    : AppButton(
                        text: 'Add To Cart',
                        onPressed: () {
                          isOnAdd();
                        }),
              )
            ],
          ),
        ));
  }
}
