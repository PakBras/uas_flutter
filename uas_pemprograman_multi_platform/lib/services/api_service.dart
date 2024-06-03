import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/water_intake.dart';

class ApiService {
  final String _baseUrl;

  ApiService(this._baseUrl);

  Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Invalid username or password');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User?> getUser(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/user/$id'));

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get user');
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<User?> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/user/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<List<WaterIntake>> getWaterIntakes(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/water/$userId'));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((e) => WaterIntake.fromJson(e)).toList();
      } else {
        throw Exception('Failed to get water intakes');
      }
    } catch (e) {
      throw Exception('Failed to get water intakes: $e');
    }
  }

  Future<WaterIntake?> addWaterIntake(WaterIntake waterIntake) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/water'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(waterIntake.toJson()),
      );

      if (response.statusCode == 201) {
        return WaterIntake.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add water intake');
      }
    } catch (e) {
      throw Exception('Failed to add water intake: $e');
    }
  }

  Future<WaterIntake?> updateWaterIntake(WaterIntake waterIntake) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/water/${waterIntake.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(waterIntake.toJson()),
      );

      if (response.statusCode == 200) {
        return WaterIntake.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update water intake');
      }
    } catch (e) {
      throw Exception('Failed to update water intake: $e');
    }
  }

  Future<bool> deleteWaterIntake(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/water/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete water intake');
      }
    } catch (e) {
      throw Exception('Failed to delete water intake: $e');
    }
  }
}
