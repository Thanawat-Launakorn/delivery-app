part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {
  final AddressModel seletedAddress;
  static final List<AddressModel> addresses = [
    AddressModel(title: 'home'),
    AddressModel(title: 'work'),
    AddressModel(title: 'other'),
  ];

  AddressInitial({AddressModel? seletedAddress})
      : seletedAddress = seletedAddress ?? addresses[0];
}

class LoadingAddressState extends AddressState {
  bool isLoading;
  LoadingAddressState({required this.isLoading});
}

class LoadingCreateAddressState extends AddressState {
  bool isLoading;
  LoadingCreateAddressState({required this.isLoading});
}

class ResponseErrorCreateAddressState extends AddressState {
  bool responseError;
  ResponseErrorCreateAddressState({required this.responseError});
}

