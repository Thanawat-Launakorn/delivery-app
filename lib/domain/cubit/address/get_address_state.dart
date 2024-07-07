part of 'get_address_cubit.dart';

sealed class GetAddressState {}

final class GetAddressInitial extends GetAddressState {}

class LoadingGetUserAddressState extends GetAddressState {
  bool isLoading;
  LoadingGetUserAddressState({required this.isLoading});
}

class ResponseGetUserAddressState extends GetAddressState {
  List<AddressResponse> response;
  ResponseGetUserAddressState({required this.response});
}

class ResponseErrorGetUserAddressState extends GetAddressState {
  bool responseError;
  ResponseErrorGetUserAddressState({required this.responseError});
}
