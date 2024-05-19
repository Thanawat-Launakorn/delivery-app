part of 'delivery.method_cubit.dart';

sealed class HoworderState {}

final class HoworderInitial extends HoworderState {}

class LoadingHoworderState extends HoworderState {
  bool isLoading;
  LoadingHoworderState({ required this.isLoading });
}