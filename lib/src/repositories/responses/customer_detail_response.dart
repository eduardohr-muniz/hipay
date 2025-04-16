import 'dart:convert';
import 'package:hipay/src/enums/document_type.dart';

class CustomerDetailResponse {
  final int id;
  final String email;
  final String name;
  final String document;
  final DocumentType documentType;
  final int companyId;
  final String customerId;
  final DateTime dateCreated;
  final DateTime dateModified;
  CustomerDetailResponse({
    this.id = 0,
    this.email = '',
    this.name = '',
    this.document = '',
    required this.documentType,
    this.companyId = 0,
    this.customerId = '',
    required this.dateCreated,
    required this.dateModified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'document': document,
      'documentType': documentType.name,
      'companyId': companyId,
      'customerId': customerId,
      'dateCreated': dateCreated.toIso8601String(),
      'dateModified': dateModified.toIso8601String(),
    };
  }

  factory CustomerDetailResponse.fromMap(Map<String, dynamic> map) {
    return CustomerDetailResponse(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      document: map['document'] ?? '',
      documentType: DocumentType.fromMap(map['documentType']),
      companyId: map['companyId']?.toInt() ?? 0,
      customerId: map['customerId'] ?? '',
      dateCreated: DateTime.parse(map['dateCreated']),
      dateModified: DateTime.parse(map['dateModified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerDetailResponse.fromJson(String source) => CustomerDetailResponse.fromMap(json.decode(source));
}
