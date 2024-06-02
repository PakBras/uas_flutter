import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/water_intake.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  List<WaterIntake> _waterIntakes = [];

  User? get user => _user;
  List<WaterIntake> get waterIntakes => _waterIntakes;

  final ApiService _apiService = ApiService();

  Future<void> login(String username, String password) async {
    _user = await _apiService.login(username, password);
    notifyListeners();
  }

  Future<void> fetchUserData(int userId) async {
    _user = await _apiService.getUser(userId);
    notifyListeners();
  }

  Future<void> updateUser(User updatedUser) async {
    _user = await _apiService.updateUser(updatedUser);
    notifyListeners();
  }

  Future<void> recordWaterIntake(WaterIntake intake) async {
    final newIntake = await _apiService.recordWaterIntake(intake);
    if (newIntake != null) {
      _waterIntakes.add(newIntake);
      notifyListeners();
    }
  }

  Future<void> fetchWaterIntake(int userId) async {
    _waterIntakes = await _apiService.getWaterIntake(userId);
    notifyListeners();
  }
}
