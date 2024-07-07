import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/domain/service/address/getAllAddressService.dart';
import 'package:flutter_application_1/domain/model/response_body/addressResponseBody.dart';

part 'get_address_state.dart';

class GetAddressCubit extends Cubit<GetAddressState> {
  GetAddressCubit() : super(GetAddressInitial());

  Future fetchAddress() async {
    emit(LoadingGetUserAddressState(isLoading: true));

    await GetAllAddressService().fetchData().then((res) {
      if (res.response_status == 200) {
        emit(LoadingGetUserAddressState(isLoading: false));
        emit(ResponseGetUserAddressState(response: res.response));
      } else {
        emit(LoadingGetUserAddressState(isLoading: false));
        emit(ResponseErrorGetUserAddressState(responseError: true));
      }
    }).onError((error, stackTrace) {
      emit(ResponseErrorGetUserAddressState(responseError: true));
    });
  }
}
