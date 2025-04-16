import 'dart:convert';

enum Status {
  accepted,
  pending;

  static Status fromMap(String status) => Status.values.firstWhere((s) => s.name.toLowerCase() == status.toLowerCase());
}

class CreateRecipientResponse {
  final String recipientId;
  final Status status;

  CreateRecipientResponse({required this.recipientId, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'recipientId': recipientId,
      'status': status.name,
    };
  }

  factory CreateRecipientResponse.fromMap(Map<String, dynamic> map) {
    return CreateRecipientResponse(
      recipientId: map['recipientId'] ?? '',
      status: Status.fromMap(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateRecipientResponse.fromJson(String source) => CreateRecipientResponse.fromMap(json.decode(source));
}
