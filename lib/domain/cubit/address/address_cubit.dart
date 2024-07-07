import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/address/address.model.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());


  void onChangeAddress(AddressModel selectAddress) {
    emit(AddressInitial(seletedAddress: selectAddress));
  }
}
