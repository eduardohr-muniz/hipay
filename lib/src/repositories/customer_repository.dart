import 'package:hipay/src/i_customer_repository.dart';
import 'package:hipay/src/models/customer.dart';

class CustomerRepository implements ICustomerRepository {
  @override
  Future<List<Customer>> listarClientes({required int pageNumber, required int pageSize}) {
    // TODO: implement listarCliente
    throw UnimplementedError();
  }

  @override
  Future<String> criarCliente(Customer customer) {
    // TODO: implement criarCliente
    throw UnimplementedError();
  }
}
