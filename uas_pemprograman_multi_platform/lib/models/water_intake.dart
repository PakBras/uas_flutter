class WaterIntake {
  final int id;
  final int userId;
  final DateTime date;
  final double amount;

  WaterIntake({
    required this.id,
    required this.userId,
    required this.date,
    required this.amount,
  });

  factory WaterIntake.fromJson(Map<String, dynamic> json) {
    return WaterIntake(
      id: json['id'],
      userId: json['user_id'],
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}