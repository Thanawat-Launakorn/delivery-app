import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/user/user_model.dart';
import 'package:flutter_application_1/domain/service/user/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _service;

  UserBloc(this._service) : super(UserInitial()) {
    on<AddUserEvent>((event, emit) async {
      emit(AddUserLoading(isLoading: true));
      await _service.addUserService(event.email, event.username).then((value) {
        emit(AddUserLoading(isLoading: false));
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });
      }).onError((error, stackTrace) {
        emit(AddUserLoading(isLoading: false));
      });
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UpdateUserLoading(isLoading: true));
      await _service
          .updateUserService(event.id, event.email, event.username)
          .then((value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          BlocProvider.of<UserBloc>(event.context).add(ReadUserDetailEvent(id: event.id));
          Navigator.pop(event.context);
        });
        emit(UpdateUserLoading(isLoading: false));

      }).onError((error, stackTrace) {
        emit(UpdateUserLoading(isLoading: false));
      });
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(DeleteUserLoading(isLoading: true));
      await _service.deleteUserService(event.id).then((value) {
        emit(DeleteUserLoading(isLoading: false));
        BlocProvider.of<UserBloc>(event.context).add(ReadUserEvent());
      }).onError((error, stackTrace) {
        emit(DeleteUserLoading(isLoading: false));
      });
    });

    on<ReadUserDetailEvent>((event, emit) async {
      await _service.fetchDetailUesr(event.id).then((value) {
        emit(ReadUserDetailState(userDetailResponse: value));
      }).onError((error, stackTrace) {
      });
      
    });

    on<ReadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      await _service.fetchUser().then((value) {
        emit(ReadUserState(userResponse: value));
      }).onError((error, stackTrace) {
        emit(UserErrorState(error: error.toString()));
      });
    });
  }
}
