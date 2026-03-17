import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:opsentra_hr/Core/local/hive_service.dart';
import 'package:opsentra_hr/features/profile/profile.service.dart';

class SyncService {
  final Connectivity _connectivity = Connectivity();
  final HiveService hiveService = HiveService();

  void start() {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await syncOfflineData();
      }
    });
  }

  Future<void> syncOfflineData() async {
    final dataList = hiveService.getAll();

    for (int i = 0; i < dataList.length; i++) {
      try {
        await ProfileService().sendProfileToApi(dataList[i]);
        await hiveService.deleteAt(i);
      } catch (_) {
        break;
      }
    }
  }
}
