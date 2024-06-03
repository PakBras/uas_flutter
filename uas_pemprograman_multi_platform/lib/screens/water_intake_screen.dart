import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class WaterIntakeScreen extends StatefulWidget {
  final User user;

  WaterIntakeScreen({required this.user});

  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  bool _isLoading = false;

  Future<void> fetchWaterIntake() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchWaterIntake(widget.user.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch water intake: $e')),
      );
    }
  }

  void recordWaterIntake() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final newIntake = WaterIntake(
        id: 0, // generate a new ID or use a UUID package
        userId: widget.user.id,
        date: DateTime.now(),
        volume: 500, // default amount or prompt user to enter
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      userProvider.recordWaterIntake(newIntake);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to record water intake: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Intake'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: fetchWaterIntake,
              child: Text('Fetch Water Intake'),
            ),
            ElevatedButton(
              onPressed: recordWaterIntake,
              child: Text('Record Water Intake'),
            ),
          ],
        ),
      ),
    );
  }
}