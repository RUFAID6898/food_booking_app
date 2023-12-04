import 'dart:convert';

import 'package:food_app/api_services/api_model.dart';
import 'package:http/http.dart' as http;

class ApiServicess {
  static const siteUrl =
      "https://run.mocky.io/v3/4d116e3e-808c-43ab-93ed-6c70540d4e18";
  Future<List<UserModel>> getuser() async {
    final response = await http.get(Uri.parse(siteUrl));

    if (response.statusCode == 200) {
      List<UserModel> userlist = [];

      List<dynamic> data = jsonDecode(response.body);

      for (Map<String, dynamic> jsonUser in data) {
        userlist.add(UserModel.fromJson(jsonUser));
      }

      return userlist;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
