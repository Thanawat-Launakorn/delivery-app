import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/constants/snack_bar.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/service/auth/auth.service.dart';

part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final CacheToken _cacheToken;

  AuthCubit(this._authService, this._cacheToken) : super(AuthInitialState());

  Future loginLogic(String email, String password, BuildContext context) async {
    emit(LoginLoadingState(isLoading: true));
    final Map<String, dynamic> login = {
      'email': email,
      'password': password,
    };
    await _authService
        .loginService(login['email'], login['password'])
        .then((value) {
      if (value.response_status == 200) {
        emit(LoginLoadingState(isLoading: false));
        _cacheToken.writeToken(value.token);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushNamed(context, '/');
        });
        snackBar(context, 'Login successfully!');
      }
    }).onError((error, stackTrace) {
      emit(LoginLoadingState(isLoading: false));
      snackBar(context, 'Login failed');
    });
  }
}
