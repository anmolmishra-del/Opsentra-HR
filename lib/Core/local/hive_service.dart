import 'package:hive/hive.dart';

class HiveService {
  final box = Hive.box('offline_queue');

  Future<void> saveOffline(Map<String, dynamic> data) async {
    await box.add(data);
    print('✅ SAVED TO HIVE → $data');
    print('📦 TOTAL RECORDS → ${box.length}');
  }

  List<Map<String, dynamic>> getAll() {
    print('📦 ALL HIVE DATA → ${box.values}');
    return box.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> deleteAt(int index) async {
    await box.deleteAt(index);
    print('🗑 DELETED INDEX → $index');
  }
}
