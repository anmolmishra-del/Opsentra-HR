import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/utils/firbase_service.dart';
import 'package:opsentra_hr/features/main/state/main_state.dart';


class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  onInit(){
    FirebaseNotificationService.init();
  }


  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
