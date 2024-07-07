import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/model/address/address.model.dart';
import 'package:flutter_application_1/domain/cubit/address/get_address_cubit.dart';
import 'package:flutter_application_1/domain/service/address/createAddressService.dart';
import 'package:flutter_application_1/domain/model/request_body/addressRequestBody.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  void onChangeAddress(AddressModel selectAddress) {
    emit(AddressInitial(seletedAddress: selectAddress));
  }

  Future createAddress(AddressRequest body, BuildContext context) async {
    emit(LoadingCreateAddressState(isLoading: true));
    await CreateAddressService().fetchData(body).then((res) {
      if (res.response_status == 201) {
        final AddressModel selectedAddress = AddressModel(title: body.method);

        emit(AddressInitial(seletedAddress: selectedAddress));
        context.read<GetAddressCubit>().fetchAddress();
        Navigator.pop(context);
      } else {
        emit(ResponseErrorCreateAddressState(responseError: true));
      }
    }).onError((error, stackTrace) {
      emit(ResponseErrorCreateAddressState(responseError: true));
    });
  }
}
