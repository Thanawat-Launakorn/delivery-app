import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
  }

  

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());
      await Future.delayed(const Duration(milliseconds: 500));
      if (event.email != '' && event.password != '') {
        debugPrint('Success');
        emit(SuccessAuthState());
      } else {
        debugPrint('failure');
        emit(FailureAuthState('error'));
      }
    } catch (err) {
      emit(FailureAuthState('error'));
    }
  }
}
