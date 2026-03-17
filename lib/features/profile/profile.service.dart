// class ProfileService {
//   Future<void> sendProfileToApi(Map<String, dynamic> data) async {
//     // API call here
//   }
// }
class ProfileService {
  Future<void> sendProfileToApi(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));
    print("Sent to server: $data");
  }
}
