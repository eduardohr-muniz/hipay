import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/repositories/responses/customer_detail_response.dart';

abstract interface class ICustomerRepository {
  /// ✅ RETURN: The customer ID
  Future<String> criarCliente({required Customer customer});

  /// ✅ RETURN: List of customers
  Future<List<Customer>> listarClientes({required int pageNumber, required int pageSize});

  Future<CustomerDetailResponse> detalharCliente({required String id});
}
