import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/domain/service/category/getAllCategoryService.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllCategoryResponseBody.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future fetchCategory() async {
    emit(CategoryLoadingState(isLoading: true));
    await GetAllCategoryService().fetchData().then((res) {
      if (res.response_status == 200) {
        emit(CategoryLoadingState(isLoading: false));
        emit(CategoryResponseState(response: res.response));
      } else {
        emit(CategoryLoadingState(isLoading: false));
        emit(CategoryResponseErrorState(responseError: true));
      }
    }).onError((error, stackTrace) {
       emit(CategoryResponseErrorState(responseError: true));
    });
  }
}
