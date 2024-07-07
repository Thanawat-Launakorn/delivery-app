import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllProductResponseBody.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _initCartItem = [];
  CartBloc() : super(CartInitial()) {
    on<AddCartEvent>((event, emit) {
      _initCartItem.add(event.product);
      emit(CartUpdated(List.from(_initCartItem)));
    });

    on<DeleteCartEvent>((event, emit) {
      final existingItemIndex =
          _initCartItem.indexWhere((item) => item.product.id == event.id);

      if (existingItemIndex != -1) {
        _initCartItem[existingItemIndex].quantity -= 1;
        if (_initCartItem[existingItemIndex].quantity == 0) {
          _initCartItem
              .removeWhere((element) => event.id == element.product.id);
        }
      }

      emit(CartUpdated(List.from(_initCartItem)));
    });

    on<UpdateCartEvent>((event, emit) {
      final existingItemIndex = _initCartItem
          .indexWhere((item) => item.product.id == event.productId);

      if (existingItemIndex != -1) {
        _initCartItem[existingItemIndex].quantity += 1;
      }

      emit(CartUpdated(List.from(_initCartItem)));
    });

    on<ClearCartEvent>((event, emit) {
      _initCartItem.clear();
      emit(CartUpdated(List.from(_initCartItem)));
    });
  }
}
