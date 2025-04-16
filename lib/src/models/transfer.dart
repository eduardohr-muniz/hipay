import 'dart:convert';

class Transfer {
  final String id;
  final int fee;
  final int amount;
  final String bankName;
  final String bankCode;
  final String agency;
  final String bankAccount;
  final String recipientId;
  final DateTime dateCreated;
  final String status;
  final int bankAccountCheckDigit;
  Transfer({
    required this.id,
    required this.fee,
    required this.amount,
    required this.bankName,
    required this.bankCode,
    required this.agency,
    required this.bankAccount,
    required this.recipientId,
    required this.dateCreated,
    required this.status,
    required this.bankAccountCheckDigit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fee': fee,
      'amount': amount,
      'bankName': bankName,
      'bankCode': bankCode,
      'agency': agency,
      'bankAccount': bankAccount,
      'recipientId': recipientId,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'status': status,
      'bankAccountCheckDigit': bankAccountCheckDigit,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      id: map['id'],
      fee: map['fee']?.toInt() ?? 0,
      amount: map['amount'],
      bankName: map['bankName'],
      bankCode: map['bankCode'],
      agency: map['agency'] ?? '',
      bankAccount: map['bankAccount'] ?? '',
      recipientId: map['recipientId'],
      dateCreated: DateTime.parse(map['dateCreated']),
      status: map['status'] ?? '',
      bankAccountCheckDigit: map['bankAccountCheckDigit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) => Transfer.fromMap(json.decode(source));

  Transfer copyWith({
    String? id,
    int? fee,
    int? amount,
    String? bankName,
    String? bankCode,
    String? agency,
    String? bankAccount,
    String? recipientId,
    DateTime? dateCreated,
    String? status,
    int? bankAccountCheckDigit,
  }) {
    return Transfer(
      id: id ?? this.id,
      fee: fee ?? this.fee,
      amount: amount ?? this.amount,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      agency: agency ?? this.agency,
      bankAccount: bankAccount ?? this.bankAccount,
      recipientId: recipientId ?? this.recipientId,
      dateCreated: dateCreated ?? this.dateCreated,
      status: status ?? this.status,
      bankAccountCheckDigit: bankAccountCheckDigit ?? this.bankAccountCheckDigit,
    );
  }
}
