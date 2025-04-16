enum DocumentType {
  cpf,
  cnpj;

  static DocumentType fromMap(String type) => DocumentType.values.firstWhere((t) => t.name.toLowerCase() == type.toLowerCase());
}
