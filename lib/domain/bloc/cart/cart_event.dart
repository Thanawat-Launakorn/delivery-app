part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddCartEvent extends CartEvent {
  final CartItem product;

  AddCartEvent({required this.product});
}

class DeleteCartEvent extends CartEvent {
  final int id;

  DeleteCartEvent({required this.id});
}

class UpdateCartEvent extends CartEvent {
  final int productId;

  UpdateCartEvent({required this.productId});
}

class ClearCartEvent extends CartEvent {}
