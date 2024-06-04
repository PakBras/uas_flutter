import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import '../models/water_intake.dart';

class UserProvider with ChangeNotifier {
  final ApiService apiService;
  User? _user;
  List<WaterIntake> _waterIntakes = [];

  UserProvider(this.apiService);

  User? get user => _user;
  List<WaterIntake> get waterIntakes => _waterIntakes;

  Future<void> login(String username, String password) async {
    _user = await apiService.login(username, password);
    notifyListeners();
  }

  Future<List<WaterIntake>> fetchWaterIntake(int userId) async {
    _waterIntakes = await apiService.getWaterIntakes(userId);
    notifyListeners();
    return _waterIntakes;
  }

  Future<void> recordWaterIntake(WaterIntake intake) async {
    await apiService.addWaterIntake(intake);
    await fetchWaterIntake(intake.userId);
  }

  Future<void> updateUser(User user) async {
    _user = await apiService.updateUser(user);
    notifyListeners();
  }
}
