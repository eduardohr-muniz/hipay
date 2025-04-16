import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hipay/src/enums/transaction_status.dart';

import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/models/hipay_item.dart';
import 'package:hipay/src/models/split.dart';

class Transaction {
  final double amount;
  final String paymentMethod;
  final String description;
  final String customerId;
  final Customer customer;
  final DateTime? expiresIn;
  final List<HipayItem> items;
  final List<HipaySplit> splits;
  final HipayTransactionStatus? status;
  final DateTime? createdAt;

  Transaction({
    required this.amount,
    this.paymentMethod = 'pix',
    this.description = '',
    this.customerId = '',
    required this.customer,
    this.expiresIn,
    this.items = const [],
    this.splits = const [],
    this.status,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = {
      'amount': amount,
      'paymentMethod': paymentMethod,
      'description': description,
      'customerId': customerId,
      'customer': customer.toMap(),
      'expiresIn': expiresIn?.millisecondsSinceEpoch,
      'items': items.map((x) => x.toMap()).toList(),
      'splits': splits.map((x) => x.toMap()).toList(),
    };
    if (expiresIn != null) {
      result['pix'] = {
        'expiresIn': expiresIn?.toIso8601String()
      };
    }
    return result;
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      amount: map['amount']?.toDouble() ?? 0.0,
      paymentMethod: map['paymentMethod'] ?? '',
      description: map['description'] ?? '',
      customerId: map['customerId'] ?? '',
      customer: Customer.fromMap(map['customer']),
      expiresIn: map['pix']['expiresIn'] != null ? DateTime.parse(map['pix']['expiresIn']) : null,
      items: List<HipayItem>.from(map['items']?.map((x) => HipayItem.fromMap(x))),
      splits: List<HipaySplit>.from(map['splits']?.map((x) => HipaySplit.fromMap(x))),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      status: map['status'] != null ? HipayTransactionStatus.fromMap(map['status']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));
}
