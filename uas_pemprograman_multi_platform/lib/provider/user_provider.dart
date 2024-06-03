import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/water_intake.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService('https://your-api-url.com'); // replace with your API URL

  List<WaterIntake> _waterIntakes = [];

  List<WaterIntake> get waterIntakes {
    return [..._waterIntakes];
  }

  Future<void> fetchWaterIntake(int userId) async {
    try {
      _waterIntakes = await _apiService.getWaterIntakes(userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch water intake: $e');
    }
  }

  void recordWaterIntake(WaterIntake intake) async {
    try {
      await _apiService.addWaterIntake(intake);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to record water intake: $e');
    }
  }

  Future<User?> login(String username, String password) async {
    try {
      final user = await _apiService.login(username, password);
      return user;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User?> updateUser(User user) async {
    try {
      final updatedUser = await _apiService.updateUser(user);
      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}