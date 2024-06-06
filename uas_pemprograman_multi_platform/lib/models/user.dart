class User {
  final int id;
  final String username;
  final String password;
  final double weight;
  final double height;
  final int age;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.weight,
    required this.height,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      weight: (json['weight'] ?? 0.0).toDouble(),
      height: (json['height'] ?? 0.0).toDouble(),
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'weight': weight,
      'height': height,
      'age': age,
    };
  }
}
