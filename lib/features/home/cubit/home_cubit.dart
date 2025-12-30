import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void loadHome() {
   
    emit(
      state.copyWith(
        isBirthday: false,
        userName: 'Praveen',
      ),
    );
  }
}
