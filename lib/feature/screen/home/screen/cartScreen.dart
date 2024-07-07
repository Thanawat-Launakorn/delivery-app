import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/modifyText/index.dart';
import 'package:flutter_application_1/route/app_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/constants/button.dart';
import 'package:flutter_application_1/domain/bloc/cart/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget caseEmpty(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 240,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage(Asset.images['emptyCart'] as String))),
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                'Your cart is empty',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Looks like you haven\'t made\nyour choice yet...',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 36,
              ),
              AppButton(
                  text: 'Start Shopping',
                  onPressed: () => Navigator.pop(context))
            ]),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: .5,
                blurRadius: .5,
              ),
            ],
          ),
          child: AppBar(
            title: Text(
              'ตะกร้าของฉัน',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final isHaveCart = state is CartUpdated && state.items.isNotEmpty;

          if (isHaveCart) {
            final sumTotal = state.items
                .map((it) => it.quantity * it.product.price)
                .reduce((prev, curr) => prev + curr);

            return Column(children: [
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    void onAdd() {
                      return BlocProvider.of<CartBloc>(context).add(
                          UpdateCartEvent(
                              productId: state.items[index].product.id));
                    }

                    void onDelete() {
                      return BlocProvider.of<CartBloc>(context).add(
                          DeleteCartEvent(id: state.items[index].product.id));
                    }

                    return Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: .5,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          state.items[index].product.image))),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalize(state.items[index].product.name),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                ),
                                Text(
                                  '\$${state.items[index].product.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: onDelete,
                                  child: Container(
                                    height: 35,
                                    width: 33,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: .5,
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: state.items[index].quantity == 1
                                        ? Icon(
                                            Icons.delete_outline,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          )
                                        : Icon(
                                            Icons.remove,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: .5,
                                      )
                                    ],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${state.items[index].quantity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                  )),
                                ),
                                GestureDetector(
                                  onTap: onAdd,
                                  child: Container(
                                    height: 35,
                                    width: 33,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 1,
                                              blurRadius: 1)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12))),
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: .5,
                        color: Colors.grey,
                      ),
                    ]);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ราคารวม',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            '${ModifyText.ModifyTextTwoDedimal(sumTotal)} บาท',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                      AppButton(
                        text: 'ถัดไป',
                        onPressed: () {
                          final CheckoutArguments args =
                              CheckoutArguments(products: state.items);
                          Navigator.pushNamed(context, '/checkout',
                              arguments: args);
                        },
                        size: AppButtonSize.MEDIUM,
                      )
                    ],
                  ),
                ),
              )
            ]);
          } else {
            return caseEmpty(context);
          }
        },
      ),
    );
  }
}
