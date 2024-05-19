import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delivery.method_state.dart';

enum DeliveryMethod {
  delivery,
  pickup
}

class DeliveryMethodCubit extends Cubit<HoworderState> {
  DeliveryMethodCubit() : super(HoworderInitial());
}
