import 'dart:convert';

import 'package:hipay/src/enums/payment_method.dart';
import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/models/split.dart';

class CreateTransactionRequest {
  final int amount;
  final HipayPaymentMethod paymentMethod;
  final String description;
  final String? customerId;
  final Customer? customer;
  final DateTime expiresIn;
  final List<HipaySplit>? splits;
  CreateTransactionRequest({
    required this.amount,
    required this.paymentMethod,
    required this.description,
    this.customerId,
    this.customer,
    required this.expiresIn,
    required this.splits,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'amount': amount,
      'paymentMethod': paymentMethod.name,
      'description': description
    };
    if (customer != null) {
      data['customer'] = customer?.toMap();
    }
    if (customerId != null) {
      data['customerId'] = customerId;
    }
    if (paymentMethod == HipayPaymentMethod.pix) {
      data['pix'] = {
        'expiresIn': expiresIn.toUtc().toIso8601String(),
      };
    }
    if (splits?.isNotEmpty ?? false) {
      data['splits'] = splits?.map((x) => x.toMap()).toList();
    }
    return data;
  }

  factory CreateTransactionRequest.fromMap(Map<String, dynamic> map) {
    return CreateTransactionRequest(
      amount: map['amount']?.toInt() ?? 0,
      paymentMethod: HipayPaymentMethod.fromMap(map['paymentMethod']),
      description: map['description'] ?? '',
      customerId: map['customerId'],
      customer: map['customer'] != null ? Customer.fromMap(map['customer']) : null,
      expiresIn: DateTime.fromMillisecondsSinceEpoch(map['expiresIn']),
      splits: map['splits'] != null ? List<HipaySplit>.from(map['splits']?.map((x) => HipaySplit.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateTransactionRequest.fromJson(String source) => CreateTransactionRequest.fromMap(json.decode(source));
}
