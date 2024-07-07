part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;

  CartUpdated(this.items);
}

class CartItem {
  final GetAllProductResponse product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
