import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/water_intake.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<User?> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<User?> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<WaterIntake?> recordWaterIntake(WaterIntake intake) async {
    final response = await http.post(
      Uri.parse('$baseUrl/water'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(intake.toJson()),
    );

    if (response.statusCode == 200) {
      return WaterIntake.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<List<WaterIntake>> getWaterIntake(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/water/$userId'));

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((model) => WaterIntake.fromJson(model)).toList();
    } else {
      return [];
    }
  }
}
