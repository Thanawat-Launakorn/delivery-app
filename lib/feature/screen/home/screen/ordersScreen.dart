import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/domain/model/response_body/getUserOrderItemResponseBody.dart';
import 'package:flutter_application_1/domain/model/response_body/getUserOrderResponseBody.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/asset/image.dart';
import 'package:flutter_application_1/domain/cubit/order/get_order_cubit.dart';
import 'package:flutter_application_1/route/app_routes.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/widget/constants/button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrderCubit>().fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    Widget orderItem(BuildContext context, GetUserOrderResponse dataOrder,
        List<OrderItemResponse> dataOrderItem) {
      final sumTotal = dataOrderItem
          .map((e) => e.quantity * e.product.price)
          .reduce((value, element) => value + element);

      DateTime originalDate = DateTime.parse(dataOrder.createdAt ?? '');
      String formattedDate =
          DateFormat('dd/MM/yyyy - HH:mm').format(originalDate);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$formattedDate',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                '${dataOrder.address!.address}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '\$$sumTotal',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ]),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 6,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: dataOrderItem.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  dataOrderItem[index].product.image))),
                    );
                  }),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
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
              'ประวัติทำรายการ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
      body: BlocBuilder<GetOrderCubit, GetOrderState>(
        builder: (context, state) {
          final isHaveOrder = (state is ResponseGetOrderState &&
              state.userOrderItemResponse.isNotEmpty &&
              state.userOrderResponse.isNotEmpty);

          if (isHaveOrder) {
            debugPrint(
                'order => ${state.userOrderResponse.where((element) => element.userId == 4).length}');
            return ListView.builder(
                itemCount: state.userOrderResponse.length,
                itemBuilder: (context, index) {
                  final order = state.userOrderResponse[index];
                  final orderItems = state.userOrderItemResponse
                      .where((item) => item.orderId == order.id)
                      .toList();
                  return orderItem(context, order, orderItems);
                });
          } else if (state is LoadingGetOrderState && state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 240,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                Asset.images['noOrders'] as String))),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    'No orders yet',
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
                    'Looks like you haven\'t ordered\nyet.',
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
                      onPressed: () {
                        onReplaceToScreen(context, AppRoutes.home);
                      })
                ]),
          );
        },
      ),
    );
  }
}
