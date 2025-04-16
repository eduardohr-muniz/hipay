library hipay;

import 'package:dio/dio.dart';
import 'package:hipay/src/client/clien_exports.dart';
import 'package:hipay/src/repositories/customer_repository.dart';
import 'package:hipay/src/repositories/i_customer_repository.dart';
import 'package:hipay/src/repositories/i_recipent_repository.dart';
import 'package:hipay/src/repositories/i_transaction_repository.dart';
import 'package:hipay/src/repositories/recipient_repository.dart';
import 'package:hipay/src/repositories/transaction_repository.dart';

class Hipay {
  Hipay({required String apiKey, bool sandbox = false, bool enableLogs = false}) {
    String baseUrl = 'https://api.hipay.com.br';
    if (sandbox) baseUrl = 'https://api-sandbox.hipay.com.br';
    _client = ClientDio(
      baseOptions: BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'X-API-KEY': apiKey
        },
      ),
      enableLogs: enableLogs,
    );
  }

  late IClient _client;

  ICustomerRepository? _customerRepository;
  ICustomerRepository get customers {
    _customerRepository ??= CustomerRepository(client: _client);
    return _customerRepository!;
  }

  IRecipientRepository? _recipientRepository;
  IRecipientRepository get recipients {
    _recipientRepository ??= RecipientRepository(client: _client);
    return _recipientRepository!;
  }

  ITransactionRepository? _transactionRepository;
  ITransactionRepository get transactions {
    _transactionRepository ??= TransactionRepository(client: _client);
    return _transactionRepository!;
  }
}
