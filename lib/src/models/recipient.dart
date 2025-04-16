// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:hipay/src/enums/document_type.dart';

import 'package:hipay/src/repositories/responses/create_recipient_response.dart';

enum HipayProcess {
  NoReservation,
  PerVolume,
  PerAnticipationDays;

  static HipayProcess fromMap(String process) => HipayProcess.values.firstWhere((p) => p.name.toLowerCase() == process.toLowerCase());
}

class Recipient {
  String id;
  DocumentType documentType;
  String name;
  String document;
  String email;
  String description;
  HipayProcess process;
  Status status;
  int volumeSetting;
  int anticipationDaysSetting;
  bool isDefault;
  DateTime dateCreated;
  Recipient({
    this.id = '',
    required this.documentType,
    this.name = '',
    this.document = '',
    this.email = '',
    this.description = '',
    required this.process,
    required this.status,
    this.volumeSetting = 0,
    this.anticipationDaysSetting = 0,
    this.isDefault = false,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'documentType': documentType.name,
      'name': name,
      'document': document,
      'email': email,
      'description': description,
      'process': process.name,
      'status': status.name,
      'volumeSetting': volumeSetting,
      'anticipationDaysSetting': anticipationDaysSetting,
      'isDefault': isDefault,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }

  factory Recipient.fromMap(Map<String, dynamic> map) {
    return Recipient(
      id: map['id'] ?? '',
      documentType: DocumentType.fromMap(map['documentType']),
      name: map['name'] ?? '',
      document: map['document'] ?? '',
      email: map['email'] ?? '',
      description: map['description'] ?? '',
      process: HipayProcess.fromMap(map['process']),
      status: Status.fromMap(map['status']),
      volumeSetting: map['volumeSetting']?.toInt() ?? 0,
      anticipationDaysSetting: map['anticipationDaysSetting']?.toInt() ?? 0,
      isDefault: map['isDefault'] ?? false,
      dateCreated: DateTime.parse(map['dateCreated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipient.fromJson(String source) => Recipient.fromMap(json.decode(source));
}
