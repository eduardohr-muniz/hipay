import 'dart:convert';

import 'package:hipay/src/models/document.dart';

class Customer {
  final String id;
  final String name;
  final String email;
  final Document? document;
  Customer({
    this.id = '',
    required this.name,
    required this.email,
    required this.document,
  });

  Map<String, dynamic> toMap() {
    final result = {
      'name': name,
      'email': email,
      'document': document?.toMap(),
    };
    if (id.isNotEmpty) {
      result['id'] = id;
    }
    return result;
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      document: (map['document']['type'] != null) ? Document.fromMap(map['document']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source));

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    Document? document,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      document: document ?? this.document,
    );
  }
}
