import 'dart:convert';

class BalanceResponse {
  final double waitingFunds;
  final double available;
  final double transferred;
  BalanceResponse({
    this.waitingFunds = 0.0,
    this.available = 0.0,
    this.transferred = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'waitingFunds': waitingFunds,
      'available': available,
      'transferred': transferred,
    };
  }

  factory BalanceResponse.fromMap(Map<String, dynamic> map) {
    return BalanceResponse(
      waitingFunds: map['waitingFunds']['amount']?.toDouble() ?? 0.0,
      available: map['available']['amount']?.toDouble() ?? 0.0,
      transferred: map['transferred']['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalanceResponse.fromJson(String source) => BalanceResponse.fromMap(json.decode(source));
}
