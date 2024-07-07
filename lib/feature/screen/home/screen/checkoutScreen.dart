import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_1/domain/cubit/address/get_address_cubit.dart';
import 'package:flutter_application_1/domain/cubit/order/create_order_cubit.dart';
import 'package:flutter_application_1/domain/model/request_body/orderRequestBody.dart';
import 'package:flutter_application_1/domain/model/response_body/addressResponseBody.dart';
import 'package:flutter_application_1/helper/modifyText/index.dart';
import 'package:flutter_application_1/route/app_arguments.dart';
import 'package:flutter_application_1/route/app_routes.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/constants/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum MethodCheckout { ADDRESS, PAYMENT, CAMPAIGNS }

class CheckOutScreen extends StatefulWidget {
  final CheckoutArguments arguments;
  const CheckOutScreen({required this.arguments, super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late String _userId;
  late String _addressId;
  @override
  void initState() {
    void getUserId() async {
      final userId = await const FlutterSecureStorage().read(key: 'userId');
      setState(() {
        if (userId != null) _userId = userId;
      });
    }

    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    Widget methodCheckout(MethodCheckout method) {
      void onSelect(BuildContext context) {
        context.read<GetAddressCubit>().fetchAddress();

        Widget itemAddress(BuildContext context, AddressResponse data) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _addressId = data.id.toString();
              });
              Navigator.pop(context);
            },
            child: Column(children: [
              ListTile(
                leading: Icon(
                  data.method == 'home'
                      ? Icons.home
                      : data.method == 'work'
                          ? Icons.work
                          : Icons.location_on_sharp,
                  size: 32,
                ),
                title: Text(data.addressTitle),
                subtitle: Text(data.address),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: .5,
                color: Colors.grey,
              ),
            ]),
          );
        }

        showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return BlocBuilder<GetAddressCubit, GetAddressState>(
                builder: (context, state) {
                  final isHaveAddress = state is ResponseGetUserAddressState &&
                      state.response.isNotEmpty;
                  if (isHaveAddress) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return itemAddress(context, state.response[index]);
                        },
                        itemCount: state.response.length,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            });
      }

      switch (method) {
        case MethodCheckout.ADDRESS:
          return GestureDetector(
            onTap: () => onSelect(context),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Address',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () =>
                            onNavigateToScreen(context, AppRoutes.myaddresses),
                        child: Text(
                          'Add Address',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: .5,
                          blurRadius: .5,
                        ),
                      ],
                    ),
                    child: const ListTile(
                      leading: Icon(
                        Icons.home,
                        size: 36,
                      ),
                      title: Text('Home'),
                      subtitle: Text('address'),
                      trailing: Icon(
                        Icons.arrow_drop_down,
                        size: 36,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        case MethodCheckout.CAMPAIGNS:
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Address',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    InkWell(
                      child: Text(
                        'Add Address',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: .5,
                      ),
                    ],
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.campaign,
                      size: 36,
                    ),
                    title: Text('Free Delivery'),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                    ),
                  ),
                )
              ],
            ),
          );
        case MethodCheckout.PAYMENT:
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    InkWell(
                      child: Text(
                        'Add Card',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: .5,
                      ),
                    ],
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.credit_card,
                      size: 36,
                    ),
                    title: Text('My Card'),
                    subtitle: Text('5282 **** **** 8342'),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                    ),
                  ),
                )
              ],
            ),
          );
      }
    }

    void onSubmit() {
      final List<Product> products = widget.arguments.products
          .map((e) => Product(productId: e.product.id, quantity: e.quantity))
          .toList();
      final OrderRequest body = OrderRequest(
          userId: int.parse(_userId),
          addressId: int.parse(_addressId),
          products: products);
      BlocProvider.of<CartBloc>(context).add(ClearCartEvent());
      context.read<CreateOrderCubit>().createOrder(body, context);
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
                'ยืนยันการสั่งซื้อ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      methodCheckout(MethodCheckout.ADDRESS),
                      methodCheckout(MethodCheckout.PAYMENT),
                      methodCheckout(MethodCheckout.CAMPAIGNS),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Summary',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: .5,
                                    blurRadius: .5,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        ModifyText.ModifyTextTwoDedimal(widget
                                            .arguments.products
                                            .map((cart) =>
                                                cart.quantity *
                                                cart.product.price)
                                            .reduce((value, element) =>
                                                value + element)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Saved',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: .5,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ModifyText.ModifyTextTwoDedimal(widget
                                            .arguments.products
                                            .map((cart) =>
                                                cart.quantity *
                                                cart.product.price)
                                            .reduce((value, element) =>
                                                value + element)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'By placing an order your agree to you',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Terms and Conditions',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    AppButton(
                        text: 'Place Order',
                        onPressed: () {
                          onSubmit();
                        })
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
