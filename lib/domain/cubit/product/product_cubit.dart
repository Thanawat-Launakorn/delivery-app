import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllProductResponseBody.dart';
import 'package:flutter_application_1/domain/service/product/getAllProductService.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future fetchProduct() async {
    emit(ProductLoadingState(isLoading: true));
    await GetAllProductService().fetchData().then((res) {
      if (res.response_status == 200) {
        emit(ProductLoadingState(isLoading: false));
        emit(ProductResponseState(response: res.response));
      } else {
        emit(ProductLoadingState(isLoading: false));
        emit(ProductResponseErrorState(responseError: true));
      }
    }).onError((error, stackTrace) {
      emit(ProductResponseErrorState(responseError: true));
    });
  }
}
