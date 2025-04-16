import 'dart:convert';

class Transfer {
  final String id;
  Transfer({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) => Transfer.fromMap(json.decode(source));
}
