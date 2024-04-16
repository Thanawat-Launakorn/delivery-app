part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class LogoutAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final error;
  FailureAuthState(this.error);
}
