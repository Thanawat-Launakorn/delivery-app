import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/domain/model/todo/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoAdd>(
      (event, emit) {},
    );

    on<TodoUpdate>(
      (event, emit) {},
    );

    on<TodoDelete>(
      (event, emit) {},
    );

    on<TodoRead>((event, emit) {
      
    });
  }
}
