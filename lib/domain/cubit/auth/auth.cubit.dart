import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/service/auth/auth.service.dart';
import 'package:flutter_application_1/utils/common.dart';

part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final CacheToken _cacheToken;

  AuthCubit(this._authService, this._cacheToken) : super(AuthInitialState());

  Future loginLogic(String email, String password, BuildContext context) async {
    final Map<String, dynamic> login = {
      'email': email,
      'password': password,
    };
    emit(LoginLoadingState(isLoading: true));
    await _authService
        .loginService(login['email'], login['password'])
        .then((value) {
      if (value.response_status == 200) {
        emit(LoginSuccessState(token: value.token));
        _cacheToken.writeToken(value.token);
      } else {
        emit(LoginFailureState(error: 'login failed'));
      }
    }).onError((error, stackTrace) {
      emit(LoginFailureState(error: 'login failed'));
    });
  }

  logoutLogic(BuildContext context) {
    _cacheToken.deleteToken();
    onReplaceToScreen(context, '/');
  }
}
