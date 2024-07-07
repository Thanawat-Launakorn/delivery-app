part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {
  bool isLoading;

  CategoryLoadingState({required this.isLoading});
}

class CategoryResponseState extends CategoryState {
  List<GetAllCategoryResponse> response;

  CategoryResponseState({required this.response});
}

class CategoryResponseErrorState extends CategoryState {
  bool responseError;

  CategoryResponseErrorState({required this.responseError});
}
