part of 'auth.cubit.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {
  bool isLoading;
  LoginLoadingState({ required this.isLoading });
}

class LoginSuccessState extends AuthState {
  String token;
  LoginSuccessState({ required this.token });
}

class LoginFailureState extends AuthState {
  String error;
  LoginFailureState({ required this.error });
}


