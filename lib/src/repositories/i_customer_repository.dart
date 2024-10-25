import 'package:hipay/src/models/customer.dart';

abstract interface class ICustomerRepository {
  /// ✅ RETURN: The customer ID
  Future<String> criarCliente(Customer customer);

  /// ✅ RETURN: List of customers
  Future<List<Customer>> listarClientes({required int pageNumber, required int pageSize});
}
