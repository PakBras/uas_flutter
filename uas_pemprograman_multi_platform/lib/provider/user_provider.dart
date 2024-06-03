import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/water_intake.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService;

  UserProvider(this._apiService);

  User? _user;
  List<WaterIntake> _waterIntakes = [];

  User? get user => _user;
  List<WaterIntake> get waterIntakes => _waterIntakes;

  Future<void> login(String username, String password) async {
    try {
      _user = await _apiService.login(username, password);
      notifyListeners();
    } catch (e) {
      // Handle login error
    }
  }

  Future<void> fetchUserData(int userId) async {
    try {
      _user = await _apiService.getUser(userId);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateUser(User updatedUser) async {
    try {
      _user = await _apiService.updateUser(updatedUser);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> recordWaterIntake(WaterIntake intake) async {
    try {
      final newIntake = await _apiService.addWaterIntake(intake);
      if (newIntake != null) {
        _waterIntakes.add(newIntake);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<List<WaterIntake>> fetchWaterIntake(int userId) async {
    try {
      _waterIntakes = await _apiService.getWaterIntakes(userId);
      notifyListeners();
      return _waterIntakes;
    } catch (e) {
      // Handle error
      return [];
    }
  }
}
