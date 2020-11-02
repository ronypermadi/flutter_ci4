import 'package:flutter_ci4/model/user.dart';
import 'package:http/http.dart' show Client;

class UserApiService {
  final String baseUrl = "http://localhost:8080/";
  Client client = Client();

  Future<List<User>> getUsers() async {
    final response = await client.get("$baseUrl/user");
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }
}
