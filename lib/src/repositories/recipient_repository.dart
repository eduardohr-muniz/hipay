import 'package:dio/dio.dart';
import 'package:hipay/src/client/clien_exports.dart';
import 'package:hipay/src/models/bank.dart';
import 'package:hipay/src/models/receip_bank_account.dart';
import 'package:hipay/src/models/recipient.dart';
import 'package:hipay/src/models/transfer.dart';
import 'package:hipay/src/repositories/i_recipent_repository.dart';
import 'package:hipay/src/repositories/requests/create_bank_account_for_receip_request.dart';
import 'package:hipay/src/repositories/requests/create_receipient_request.dart';
import 'package:hipay/src/repositories/responses/balance_response.dart';
import 'package:hipay/src/repositories/responses/create_recipient_response.dart';

class RecipientRepository implements IRecipientRepository {
  final IClient client;

  RecipientRepository({required this.client});
  @override
  Future<String> criarContaBancariaParaRecebedor({required String receipId, required String pixKey, required String agency, required String agencyVerificationDigit, required String bankCode, required String account, required String accountVerificationDigit}) async {
    final modelRequest = CreateBankAccountForReceipRequest(
      receipId: receipId,
      pixKey: pixKey,
      agency: agency,
      agencyVerificationDigit: agencyVerificationDigit,
      bankCode: bankCode,
      account: account,
      accountVerificationDigit: accountVerificationDigit,
    );
    final request = await client.post(
      '/v1/Recipients/recipients/$receipId/bank-accounts',
      data: modelRequest.toMap(),
    );
    final data = request.data;
    return data['bankAccountId'];
  }

  @override
  Future<CreateRecipientResponse> criarRecebedor({
    required String documentType,
    required String name,
    required String document,
    required String email,
    required String description,
    required HipayProcess process,
    required int volumeSetting,
    required int anticipationDaysSetting,
  }) async {
    final recipient = CreateReceipientRequest(documentType: documentType, name: name, document: document, email: email, description: description, process: process);

    final request = await client.post(
      '/v1/Recipients',
      data: recipient.toMap(),
    );

    final data = request.data;
    return CreateRecipientResponse.fromMap(data);
  }

  @override
  Future<String> criarTransferenciaRecebedor({required String receipId, required int amount, required String bankAccountId, required String idempotencyKey, double? transferFee, String? captchaToken}) async {
    final request = await client.post('/v1/Recipients/$receipId/transfers', headers: {
      "Idempotency-Key": idempotencyKey
    }, data: {
      'amount': amount,
      'bankAccountId': bankAccountId,
      'transferFee': transferFee
    });
    return request.data['id'];
  }

  @override
  Future<Recipient> detalharRecebedor({required String receipId}) async {
    final request = await client.get('/v1/Recipients/$receipId');
    return Recipient.fromMap(request.data);
  }

  @override
  Future<Transfer> detalharTransferenciaRecebedor({required String receipId, required String transferId}) async {
    final result = await client.get('/v1/Recipients/$receipId/transfers/$transferId');
    return Transfer.fromMap(result.data);
  }

  @override
  Future<List<ReceipBankAccount>> listarContasBancariasRecebedor({required String receipId, required int pageNumber, required int pageSize}) async {
    final request = await client.get('/v1/Recipients/$receipId/bank-accounts?pageNumber=$pageNumber&pageSize=$pageSize');
    final List list = request.data;
    return list.map((e) => ReceipBankAccount.fromMap(e)).toList();
  }

  @override
  Future<List<Recipient>> listarRecebedores({required int pageNumber, required int pageSize}) async {
    final request = await client.get('/v1/Recipients?pageNumber=$pageNumber&pageSize=$pageSize');

    final List list = request.data;
    return list.map((e) => Recipient.fromMap(e)).toList();
  }

  @override
  Future<List<Transfer>> listarTransferenciasRecebor({required String receipId, required int pageNumber, required int pageSize}) async {
    final result = await client.get('/v1/Recipients/$receipId/transfers?pageNumber=$pageNumber&pageSize=$pageSize');
    final List list = result.data;
    return list.map((e) => Transfer.fromMap(e)).toList();
  }

  @override
  Future<BalanceResponse> verificarSaldo({required String receipId}) async {
    final request = await client.get('/v1/Recipients/$receipId/balance');
    final data = request.data;
    return BalanceResponse.fromMap(data);
  }

  @override
  Future<List<Bank>> getBanks() async {
    final dio = ClientDio(baseOptions: BaseOptions(), enableLogs: true);
    final result = await dio.get('https://brasilapi.com.br/api/banks/v1');
    final List list = result.data;
    return (list.map((e) => Bank.fromMap(e)).toList()).where((e) => e.code != '-1').toList();
  }
}
