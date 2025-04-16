import 'dart:convert';

import 'package:hipay/src/models/bank.dart';

class CreateBankAccountForReceipRequest {
  final String receipId;
  final String pixKey;
  final String agency;
  final String agencyVerificationDigit;
  final String bankCode;
  final String account;
  final String accountVerificationDigit;
  CreateBankAccountForReceipRequest({
    required this.receipId,
    required this.pixKey,
    required this.agency,
    required this.agencyVerificationDigit,
    required this.bankCode,
    required this.account,
    required this.accountVerificationDigit,
  });

  Map<String, dynamic> toMap() {
    return {
      'receipId': receipId,
      'pixKey': pixKey,
      'agency': agency,
      'agencyVerificationDigit': agencyVerificationDigit,
      'bankCode': bankCode,
      'account': account,
      'accountVerificationDigit': accountVerificationDigit,
    };
  }

  factory CreateBankAccountForReceipRequest.fromMap(Map<String, dynamic> map) {
    return CreateBankAccountForReceipRequest(
      receipId: map['receipId'] ?? '',
      pixKey: map['pixKey'] ?? '',
      agency: map['agency'] ?? '',
      agencyVerificationDigit: map['agencyVerificationDigit'] ?? '',
      bankCode: map['bankCode'].toString(),
      account: map['account'] ?? '',
      accountVerificationDigit: map['accountVerificationDigit'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBankAccountForReceipRequest.fromJson(String source) => CreateBankAccountForReceipRequest.fromMap(json.decode(source));
}
