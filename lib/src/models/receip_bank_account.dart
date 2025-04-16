import 'dart:convert';

class ReceipBankAccount {
  final String id;
  final String recipientId;
  final String pixKey;
  final String agency;
  final String bankName;
  final String bankCode;
  final String account;
  final String accountVerificationDigit;
  final String documentNumber;
  final String legalName;
  final DateTime dateCreated;

  ReceipBankAccount({required this.id, required this.recipientId, required this.pixKey, required this.agency, required this.bankName, required this.bankCode, required this.account, required this.accountVerificationDigit, required this.documentNumber, required this.legalName, required this.dateCreated});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipientId': recipientId,
      'pixKey': pixKey,
      'agency': agency,
      'bankName': bankName,
      'bankCode': bankCode,
      'account': account,
      'accountVerificationDigit': accountVerificationDigit,
      'documentNumber': documentNumber,
      'legalName': legalName,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
    };
  }

  factory ReceipBankAccount.fromMap(Map<String, dynamic> map) {
    return ReceipBankAccount(
      id: map['id'] ?? '',
      recipientId: map['recipientId'] ?? '',
      pixKey: map['pixKey'] ?? '',
      agency: map['agency'] ?? '',
      bankName: map['bankName'] ?? '',
      bankCode: map['bankCode'].toString(),
      account: map['account'] ?? '',
      accountVerificationDigit: map['accountVerificationDigit'] ?? '',
      documentNumber: map['documentNumber'] ?? '',
      legalName: map['legalName'] ?? '',
      dateCreated: DateTime.parse(map['dateCreated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceipBankAccount.fromJson(String source) => ReceipBankAccount.fromMap(json.decode(source));
}
