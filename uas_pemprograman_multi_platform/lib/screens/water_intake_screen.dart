import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/water_intake.dart';
import '../provider/user_provider.dart';


class WaterIntakeScreen extends StatelessWidget {
  final User user;

  WaterIntakeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Water Intake History')),
      body: FutureBuilder<List<WaterIntake>>(
        future: userProvider.fetchWaterIntake(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No water intake history'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final intake = snapshot.data![index];
                return ListTile(
                  title: Text('Drank water'),
                  subtitle: Text(intake.timestamp.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
