import 'dart:convert';
import 'package:hipay/src/enums/payment_method.dart';
import 'package:hipay/src/enums/transaction_status.dart';
import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/models/hipay_item.dart';
import 'package:hipay/src/models/split.dart';

class Transaction {
  final String id;
  final DateTime dateCreated;
  final HipayTransactionStatus status;
  final int amount;
  final HipayPaymentMethod paymentMethod;
  final Customer customer;
  final List<HipayItem> items;
  final List<HipaySplit> splits;
  Transaction({
    required this.id,
    required this.dateCreated,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    required this.customer,
    required this.items,
    required this.splits,
  });

  Transaction copyWith({
    String? id,
    DateTime? dateCreated,
    HipayTransactionStatus? status,
    int? amount,
    HipayPaymentMethod? paymentMethod,
    Customer? customer,
    List<HipayItem>? items,
    List<HipaySplit>? splits,
  }) {
    return Transaction(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      customer: customer ?? this.customer,
      items: items ?? this.items,
      splits: splits ?? this.splits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'status': status.name,
      'amount': amount,
      'paymentMethod': paymentMethod.name,
      'customer': customer.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
      'splits': splits.map((x) => x.toMap()).toList(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      dateCreated: DateTime.parse(map['dateCreated']),
      status: HipayTransactionStatus.fromMap(map['status']),
      amount: map['amount']?.toInt(),
      paymentMethod: HipayPaymentMethod.fromMap(map['paymentMethod']),
      customer: Customer.fromMap(map['customer']),
      items: List<HipayItem>.from(map['items']?.map((x) => HipayItem.fromMap(x))),
      splits: List<HipaySplit>.from(map['splits']?.map((x) => HipaySplit.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));
}
