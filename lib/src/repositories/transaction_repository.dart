import 'package:hipay/src/client/zz_client_export.dart';
import 'package:hipay/src/enums/payment_method.dart';
import 'package:hipay/src/enums/transaction_status.dart';
import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/models/split.dart';
import 'package:hipay/src/models/transaction.dart';
import 'package:hipay/src/repositories/i_transaction_repository.dart';
import 'package:hipay/src/repositories/requests/create_transaction_request.dart';
import 'package:hipay/src/repositories/responses/transaction_response.dart';

class TransactionRepository extends ITransactionRepository {
  final IClient client;
  TransactionRepository({required this.client});

  @override
  Future<TransactionResponse> createTransaction({required int amount, required HipayPaymentMethod paymentMethod, required String description, required DateTime expiresIn, Customer? customer, String? customerId, List<HipaySplit>? splits}) async {
    final createTransaction = CreateTransactionRequest(amount: amount, paymentMethod: paymentMethod, description: description, expiresIn: expiresIn, splits: splits, customer: customer, customerId: customerId);
    final response = await client.post('/v1/Transactions', data: createTransaction.toMap());

    return TransactionResponse.fromMap(response.data);
  }

  @override
  Future<Transaction> detalharTransacao({required String transactionId}) async {
    final response = await client.get('/v1/Transactions/$transactionId');
    return Transaction.fromMap(response.data);
  }

  @override
  Future<List<Transaction>> listarTransacoes({required int pageNumber, required int pageSize, HipayTransactionStatus? status}) async {
    String query = '/v1/Transactions?pageNumber=$pageNumber&pageSize=$pageSize';
    if (status != null) {
      query += '&status=${status.name}';
    }
    final response = await client.get(query);

    final List list = response.data;
    return list.map((e) => Transaction.fromMap(e)).toList();
  }

  @override
  Future<void> reembolsarTransacao({required String transactionId}) async {
    await client.post('/v1/Transactions/$transactionId/refund');
  }
}
