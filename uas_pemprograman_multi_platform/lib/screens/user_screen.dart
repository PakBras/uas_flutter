import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';

class UserScreen extends StatefulWidget {
  final User user;

  const UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _ageController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: widget.user.weight.toString());
    _heightController = TextEditingController(text: widget.user.height.toString());
    _ageController = TextEditingController(text: widget.user.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updateUser,
                    child: const Text('Update'),
                  ),
          ],
        ),
      ),
    );
  }

  void _updateUser() async {
    setState(() {
      _isLoading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    User updatedUser = User(
      id: widget.user.id,
      username: widget.user.username,
      password: widget.user.password,
      weight: double.parse(_weightController.text),
      height: double.parse(_heightController.text),
      age: int.parse(_ageController.text),
    );

    await userProvider.updateUser(updatedUser);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User data updated successfully')),
    );
  }
}
