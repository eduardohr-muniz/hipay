import 'dart:convert';

class Bank {
  final String ispb;
  final String name;
  final String code;
  final String fullName;
  Bank({
    required this.ispb,
    required this.name,
    required this.code,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'ispb': ispb,
      'name': name,
      'code': code,
      'fullName': fullName,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      ispb: map['ispb'] ?? '-',
      name: map['name'] ?? 'undefined',
      code: map['code']?.toString() ?? '-1',
      fullName: map['fullName'] ?? '-',
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));
}
