import 'package:flutter_application_1/domain/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllProductResponseBody.dart';

class CategoryDetailArguments {
  final int id;

  const CategoryDetailArguments({required this.id});
}

class ProductDetailArguments {
  final GetAllProductResponse product;

  ProductDetailArguments({required this.product});
}

class CheckoutArguments {
  final List<CartItem> products;

  CheckoutArguments({required this.products});
}
