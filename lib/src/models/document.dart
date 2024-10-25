import 'dart:convert';

enum DocumentType {
  cpf,
  cnpj;

  static DocumentType fromMap(String type) => DocumentType.values.firstWhere((t) => t.name == type);
}

class Document {
  final String number;
  final DocumentType type;
  Document({
    required this.number,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'type': type.name,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      number: map['number'] ?? '',
      type: DocumentType.fromMap(map['type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source));

  Document copyWith({
    String? number,
    DocumentType? type,
  }) {
    return Document(
      number: number ?? this.number,
      type: type ?? this.type,
    );
  }
}