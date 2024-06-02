class WaterIntake {
  final DateTime date;
  final double amount; 

  WaterIntake({
    required this.date,
    required this.amount,
  });

  factory WaterIntake.fromJson(Map<String, dynamic> json) {
    return WaterIntake(
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}
