part of 'create_order_cubit.dart';

sealed class CreateOrderState {}

final class CreateOrderInitial extends CreateOrderState {}

class LoadingCreateOrderState extends CreateOrderState {
  bool isLoading;
  LoadingCreateOrderState({required this.isLoading});
}

class ResponseErrorCreateOrderState extends CreateOrderState {
  bool responseError;
  ResponseErrorCreateOrderState({required this.responseError});
}
