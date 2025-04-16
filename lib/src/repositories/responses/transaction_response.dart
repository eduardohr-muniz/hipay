import 'dart:convert';

import 'package:hipay/src/enums/transaction_status.dart';

class TransactionResponse {
  final String transactionId;
  final String checkoutUrl;
  final HipayTransactionStatus status;
  final String qrCode;
  TransactionResponse({
    required this.transactionId,
    required this.checkoutUrl,
    required this.status,
    required this.qrCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'checkoutUrl': checkoutUrl,
      'status': status.name,
      'qrCode': qrCode,
    };
  }

  factory TransactionResponse.fromMap(Map<String, dynamic> map) {
    return TransactionResponse(
      transactionId: map['transactionId'] ?? '',
      checkoutUrl: map['checkoutUrl'] ?? '',
      status: HipayTransactionStatus.fromMap(map['status']),
      qrCode: map['qrCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionResponse.fromJson(String source) => TransactionResponse.fromMap(json.decode(source));
}
