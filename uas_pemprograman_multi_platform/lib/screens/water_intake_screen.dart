import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/water_intake.dart';
import '../provider/user_provider.dart';

class WaterIntakeScreen extends StatelessWidget {
  final User user;

  const WaterIntakeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Water Intake History')),
      body: RefreshIndicator(
        onRefresh: () async {
          await userProvider.fetchWaterIntake(user.id);
        },
        child: FutureBuilder<List<WaterIntake>>(
          future: userProvider.fetchWaterIntake(user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No water intake history'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final intake = snapshot.data![index];
                  return ListTile(
                    title: const Text('Drank water'),
                    subtitle: Text(DateFormat.yMMMd().add_Hms().format(intake.date)),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newIntake = WaterIntake(
            id: 0,
            userId: user.id,
            date: DateTime.now(),
            amount: 500,
          );
          userProvider.recordWaterIntake(newIntake);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
