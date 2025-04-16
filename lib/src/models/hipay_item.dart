import 'dart:convert';

class HipayItem {
  final String title;
  final double unitPrice;
  final int quantity;
  final bool tangible;
  HipayItem({
    this.title = '',
    this.unitPrice = 0.0,
    this.quantity = 0,
    this.tangible = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'tangible': tangible,
    };
  }

  factory HipayItem.fromMap(Map<String, dynamic> map) {
    return HipayItem(
      title: map['title'] ?? '',
      unitPrice: map['unitPrice']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      tangible: map['tangible'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory HipayItem.fromJson(String source) => HipayItem.fromMap(json.decode(source));
}
