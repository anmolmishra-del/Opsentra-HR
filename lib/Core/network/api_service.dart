
import 'package:opsentra_hr/Core/constants/api_constants.dart';
import 'package:opsentra_hr/Core/network/api_client.dart';

import '../../core/storage/secure_storage.dart';

class AuthApi {
  final ApiClient _client = ApiClient();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      ApiEndpoints.baseUrl + ApiEndpoints.login,
      body: {
        "email": email,
        "password": password,
      },
    );

    final token = response["access_token"];
    if (token == null) {
      throw Exception("Token missing");
    }

    await SecureStorage.saveToken(token);
  }

  Future<void> logout() async {
    await SecureStorage.clear();
  }
}
