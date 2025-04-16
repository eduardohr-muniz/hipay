import 'dart:convert';

import 'package:hipay/src/models/recipient.dart';

class CreateReceipientRequest {
  final String documentType;
  final String name;
  final String document;
  final String email;
  final String description;
  final HipayProcess process;
  final int volumeSetting;
  final int anticipationDaysSetting;
  CreateReceipientRequest({
    required this.documentType,
    required this.name,
    required this.document,
    required this.email,
    required this.description,
    required this.process,
    this.volumeSetting = 0,
    this.anticipationDaysSetting = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'documentType': documentType,
      'name': name,
      'document': document,
      'email': email,
      'description': description,
      'process': process.name,
      'volumeSetting': volumeSetting,
      'anticipationDaysSetting': anticipationDaysSetting,
    };
  }

  factory CreateReceipientRequest.fromMap(Map<String, dynamic> map) {
    return CreateReceipientRequest(
      documentType: map['documentType'] ?? '',
      name: map['name'] ?? '',
      document: map['document'] ?? '',
      email: map['email'] ?? '',
      description: map['description'] ?? '',
      process: HipayProcess.fromMap(map['process']),
      volumeSetting: map['volumeSetting']?.toInt() ?? 0,
      anticipationDaysSetting: map['anticipationDaysSetting']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateReceipientRequest.fromJson(String source) => CreateReceipientRequest.fromMap(json.decode(source));
}
