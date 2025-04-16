import 'package:hipay/src/enums/payment_method.dart';
import 'package:hipay/src/enums/transaction_status.dart';
import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/models/split.dart';
import 'package:hipay/src/models/transaction.dart';
import 'package:hipay/src/repositories/responses/transaction_response.dart';

abstract class ITransactionRepository {
  Future<TransactionResponse> createTransaction({
    required int amount,
    required HipayPaymentMethod paymentMethod,
    required String description,
    required DateTime expiresIn,
    Customer? customer,
    String? customerId,
    List<HipaySplit>? splits,
  });

  Future<List<Transaction>> listarTransacoes({required int pageNumber, required int pageSize, HipayTransactionStatus? status});

  Future<Transaction> detalharTransacao({required String transactionId});

  Future<void> reembolsarTransacao({required String transactionId});
}
