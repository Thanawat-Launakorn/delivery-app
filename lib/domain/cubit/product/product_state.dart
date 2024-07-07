part of 'product_cubit.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {
  bool isLoading;

  ProductLoadingState({required this.isLoading});
}

class ProductResponseState extends ProductState {
  List<GetAllProductResponse> response;

  ProductResponseState({required this.response});
}

class ProductResponseErrorState extends ProductState {
  bool responseError;

  ProductResponseErrorState({required this.responseError});
}
