import 'dart:convert';

class HipaySplit {
  final bool chargeProcessingFee;
  final bool liable;
  final String recipientId;
  final double amount;
  HipaySplit({
    this.chargeProcessingFee = false,
    this.liable = false,
    this.recipientId = '',
    this.amount = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'chargeProcessingFee': chargeProcessingFee,
      'liable': liable,
      'recipientId': recipientId,
      'amount': amount,
    };
  }

  factory HipaySplit.fromMap(Map<String, dynamic> map) {
    return HipaySplit(
      chargeProcessingFee: map['chargeProcessingFee'] ?? false,
      liable: map['liable'] ?? false,
      recipientId: map['recipientId'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HipaySplit.fromJson(String source) => HipaySplit.fromMap(json.decode(source));
}
