import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../models/water_intake.dart';

class WaterIntakeScreen extends StatelessWidget {
  const WaterIntakeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake History'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            final waterIntakes = userProvider.waterIntakes;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: waterIntakes.length,
              itemBuilder: (context, index) {
                final intake = waterIntakes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.local_drink, color: Colors.blueAccent),
                    title: const Text(
                      'Drank water',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().add_Hms().format(intake.date),
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          final newIntake = WaterIntake(
            id: 0,
            userId: Provider.of<UserProvider>(context, listen: false).user!.id,
            date: DateTime.now(),
            amount: 500,
          );
          Provider.of<UserProvider>(context, listen: false).recordWaterIntake(newIntake);
        },
        child: const Icon(Icons.add, color: Colors.blueAccent),
      ),
    );
  }
}
