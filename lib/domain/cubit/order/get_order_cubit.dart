import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/response_body/getUserOrderItemResponseBody.dart';
import 'package:flutter_application_1/domain/service/order/getUserOrderItemService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_1/domain/service/order/getUserOrderService.dart';
import 'package:flutter_application_1/domain/model/response_body/getUserOrderResponseBody.dart';

part 'get_order_state.dart';

class GetOrderCubit extends Cubit<GetOrderState> {
  GetOrderCubit() : super(GetOrderInitial());

  Future<void> fetchOrder() async {
    emit(LoadingGetOrderState(isLoading: true));

    try {
      final userId = await const FlutterSecureStorage().read(key: 'userId');

      if (userId == null) {
        emit(ResponseErrorGetOrderState(responseError: true));
        return;
      }

      final getUserOrderResponse = await GetUserOrderService().fetchData();

      final getUserOrderItemResponse =
          await GetUserOrderItemService().fetchData();

      if (getUserOrderResponse.response_status == 200 &&
          getUserOrderItemResponse.response_status == 200) {
        emit(LoadingGetOrderState(isLoading: false));
        emit(ResponseErrorGetOrderState(responseError: false));

        emit(ResponseGetOrderState(
          userOrderResponse: getUserOrderResponse.response
              .where((element) => element.userId == int.parse(userId))
              .toList(),
          userOrderItemResponse: getUserOrderItemResponse.response,
        ));
      } else {
        emit(LoadingGetOrderState(isLoading: false));

        emit(ResponseErrorGetOrderState(responseError: true));
      }
    } catch (error) {
      print('Error fetching orders: $error');
      emit(LoadingGetOrderState(isLoading: false));

      emit(ResponseErrorGetOrderState(responseError: true));
    }
  }
}
