library hipay;

import 'package:hipay/src/repositories/customer_repository.dart';
import 'package:hipay/src/repositories/i_customer_repository.dart';
import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/models/document.dart';

class Hipay {
  final String apiKey;
  final bool sandbox;
  final bool enableLogs;

  Hipay({required this.apiKey, this.sandbox = false, this.enableLogs = false});

  late final ICustomerRepository? _customerRepository;

  ICustomerRepository get customers {
    _customerRepository ??= CustomerRepository();
    return _customerRepository!;
  }
}

// teste de estrutura
void main() {
  final hipay = Hipay(apiKey: 'api_key');

  hipay.customers.criarCliente(Customer(name: 'edu', email: 'edu@gmail', document: Document(number: '123', type: DocumentType.cpf)));
}
