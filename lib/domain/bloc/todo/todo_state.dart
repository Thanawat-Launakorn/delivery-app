part of 'todo_bloc.dart';
 
class TodoState {
}

final class TodoInitial extends TodoState {}

class ReadTodoState extends TodoState {
  final List<Todo> todos;
  ReadTodoState({ required this.todos });
}
