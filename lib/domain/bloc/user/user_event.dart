part of 'user_bloc.dart';

abstract class UserEvent {}

class AddUserEvent extends UserEvent {
  final String username;
  final String email;
  final BuildContext context;

  AddUserEvent(
      {required this.username, required this.email, required this.context});
}

class ReadUserEvent extends UserEvent {}

class ReadUserDetailEvent extends UserEvent {
  final int id;

  ReadUserDetailEvent({ required this.id });
}

class DeleteUserEvent extends UserEvent {
  final int id;
  final BuildContext context;

  DeleteUserEvent({required this.id, required this.context });
}

class UpdateUserEvent extends UserEvent {
  final int id;
  final String username;
  final String email;
  final BuildContext context;
  UpdateUserEvent(
      {required this.id,
      required this.username,
      required this.email,
      required this.context});
}
