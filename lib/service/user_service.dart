import 'dart:convert';

import 'package:flutter_ci4/model/user.dart';
import 'package:http/http.dart' show Client;

class UserApiService {
  final String baseUrl = "https://ci4.ronypermadi.com/public/";
  Client client = Client();

  Future<List<User>> getUsers() async {
    final response = await client.get("$baseUrl/user");
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createUser(User data) async {
    final response = await client.post("$baseUrl/user/create", body: {
      "fullname": data.fullName,
      "jenjang": data.jenjang,
      "gender": data.gender,
      "phone": data.phone
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUserBy(int id) async {
    final response = await client.get("$baseUrl/user/getUserBy/$id");
    if (response.statusCode == 200) {
      final data = User.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateUser({int id, User data}) async {
    final response = await client.post("$baseUrl/user/update/$id", body: {
      "fullname": data.fullName,
      "jenjang": data.jenjang,
      "gender": data.gender,
      "phone": data.phone
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteUser({int id}) async {
    // ganti dengan method get juga gpph
    final response = await client.delete("$baseUrl/user/delete/$id");
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
