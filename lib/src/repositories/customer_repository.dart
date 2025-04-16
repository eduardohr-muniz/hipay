import 'package:hipay/src/client/clien_exports.dart';
import 'package:hipay/src/repositories/i_customer_repository.dart';
import 'package:hipay/src/models/customer.dart';
import 'package:hipay/src/repositories/responses/customer_detail_response.dart';

class CustomerRepository implements ICustomerRepository {
  final IClient client;

  CustomerRepository({required this.client});
  @override
  Future<List<Customer>> listarClientes({required int pageNumber, required int pageSize}) async {
    final request = await client.get('/v1/Customers?pageNumber=$pageNumber&pageSize=$pageSize');
    final List list = request.data;
    return list.map((e) => Customer.fromMap(e)).toList();
  }

  @override
  Future<String> criarCliente({required Customer customer}) async {
    final request = await client.post('/v1/Customers', data: customer.toMap());
    final data = request.data;
    return data['customerId'];
  }

  @override
  Future<CustomerDetailResponse> detalharCliente({required String id}) async {
    final request = await client.get('/v1/Customers/$id');
    return CustomerDetailResponse.fromMap(request.data);
  }
}
