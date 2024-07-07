import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/cubit/order/get_order_cubit.dart';
import 'package:flutter_application_1/domain/model/request_body/orderRequestBody.dart';
import 'package:flutter_application_1/domain/service/order/createOrderService.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  Future createOrder(OrderRequest body, BuildContext context) async {
    emit(LoadingCreateOrderState(isLoading: true));
    await CreateOrderService().fetchData(body).then((res) {
      if (res.response_status == 201) {
        emit(LoadingCreateOrderState(isLoading: false));
        context.read<GetOrderCubit>().fetchOrder();
        onNavigateToScreen(context, '/successOrder');
      } else {
        emit(LoadingCreateOrderState(isLoading: false));
        emit(ResponseErrorCreateOrderState(responseError: true));
      }
    }).onError((error, stackTrace) {
      emit(LoadingCreateOrderState(isLoading: false));
      emit(ResponseErrorCreateOrderState(responseError: true));
    });
  }
}
