import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/common.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/service/auth/authService.dart';
import 'package:flutter_application_1/domain/model/request_body/authRequestBody.dart';

part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final CacheToken _cacheToken;

  AuthCubit(this._authService, this._cacheToken) : super(AuthInitialState());

  Future loginLogic(AuthRequest body, BuildContext context) async {
    emit(LoginLoadingState(isLoading: true));
    await _authService.loginService(body).then((value) {
      if (value.response_status == 200) {
        if (value.role == 'client') {
          emit(LoginSuccessState(token: value.access_token));
          _cacheToken.writeToken(value.access_token);
        } else {
          emit(LoginFailureState(error: 'not permission'));
        }
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
