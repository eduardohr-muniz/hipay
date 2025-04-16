enum HipayTransactionStatus {
  created,
  processing,
  authorized,
  paid,
  refunded,
  waitingPayment,
  pendingRefund,
  refused,
  chargeback,
  analysing,
  pendingReview;

  static String captalize(HipayTransactionStatus status) => status.name[0].toUpperCase() + status.name.substring(1);
  static HipayTransactionStatus fromMap(String type) => HipayTransactionStatus.values.firstWhere((t) => t.name.toLowerCase() == type.toLowerCase());
}
