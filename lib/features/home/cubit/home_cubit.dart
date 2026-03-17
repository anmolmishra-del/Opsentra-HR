import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/sync/sync_service.dart';
import '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SyncService syncService;
  HomeCubit(this.syncService) : super(const HomeState()) {
    startSync();
  }
  void startSync() {
    syncService.start();
  }

  void loadHome() {
    emit(state.copyWith(isBirthday: false, userName: 'Praveen'));
  }
}
