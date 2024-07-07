part of 'get_order_cubit.dart';

abstract class GetOrderState {
  const GetOrderState();
}

class GetOrderInitial extends GetOrderState {
  const GetOrderInitial();
}

class LoadingGetOrderState extends GetOrderState {
  final bool isLoading;

  LoadingGetOrderState({required this.isLoading});
}

class ResponseGetOrderState extends GetOrderState {
  final List<GetUserOrderResponse> userOrderResponse;
  final List<OrderItemResponse> userOrderItemResponse;

  ResponseGetOrderState({
    required this.userOrderResponse,
    required this.userOrderItemResponse,
  });
}

class ResponseErrorGetOrderState extends GetOrderState {
  final bool responseError;

  ResponseErrorGetOrderState({required this.responseError});
}
