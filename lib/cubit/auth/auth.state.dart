part of 'auth.cubit.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {
  bool isLoading;
  LoginLoadingState({ required this.isLoading });
}


