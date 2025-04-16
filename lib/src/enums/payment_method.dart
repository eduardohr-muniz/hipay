enum HipayPaymentMethod {
  pix;

  static HipayPaymentMethod fromMap(String type) => HipayPaymentMethod.values.firstWhere((t) => t.name.toLowerCase() == type.toLowerCase());
}
