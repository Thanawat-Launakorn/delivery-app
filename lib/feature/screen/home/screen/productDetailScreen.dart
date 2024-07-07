import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/colors.dart';
import 'package:flutter_application_1/route/app_arguments.dart';
import 'package:flutter_application_1/widget/constants/button.dart';
import 'package:flutter_application_1/domain/bloc/cart/cart_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailArguments arguments;
  const ProductDetailScreen({required this.arguments, super.key});

  Widget amountButton(BuildContext context, Function() addCart,
      Function() deleteCart, int quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: deleteCart,
          child: Container(
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
            child: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 24,
            ),
          ),
        ),
        Container(
          width: 65,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary),
          child: Center(
              child: Text(
            '$quantity',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.colors['white']),
          )),
        ),
        GestureDetector(
          onTap: addCart,
          child: Container(
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            arguments.product.category.category,
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          margin: const EdgeInsets.only(bottom: 32),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(arguments.product.image))),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '\$${arguments.product.price}',
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
                                  capitalize(arguments.product.name),
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        capitalize(
                                            arguments.product.description),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black87),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final isHaveCart = state is CartUpdated &&
                      state.items.isNotEmpty &&
                      state.items
                          .where(
                              (item) => item.product.id == arguments.product.id)
                          .isNotEmpty;
                  if (isHaveCart) {
                    void onAdd() {
                      return BlocProvider.of<CartBloc>(context).add(
                          UpdateCartEvent(productId: arguments.product.id));
                    }

                    void onDelete() {
                      return BlocProvider.of<CartBloc>(context)
                          .add(DeleteCartEvent(id: arguments.product.id));
                    }

                    final currentCartQuantity = state.items
                        .firstWhere(
                            (item) => item.product.id == arguments.product.id)
                        .quantity;

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: amountButton(
                          context, onAdd, onDelete, currentCartQuantity),
                    );
                  } else {
                    return AppButton(
                        text: 'Add To Cart',
                        onPressed: () {
                          final CartItem product =
                              CartItem(product: arguments.product);
                          BlocProvider.of<CartBloc>(context)
                              .add(AddCartEvent(product: product));
                        });
                  }
                },
              )
            ],
          ),
        ));
  }
}
