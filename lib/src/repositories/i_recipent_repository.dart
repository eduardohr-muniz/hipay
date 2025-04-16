import 'package:hipay/src/models/bank.dart';
import 'package:hipay/src/models/receip_bank_account.dart';
import 'package:hipay/src/models/recipient.dart';
import 'package:hipay/src/models/transfer.dart';
import 'package:hipay/src/repositories/requests/create_receipient_request.dart';
import 'package:hipay/src/repositories/responses/balance_response.dart';
import 'package:hipay/src/repositories/responses/create_recipient_response.dart';

abstract interface class IRecipientRepository {
  Future<CreateRecipientResponse> criarRecebedor({
    required String documentType,
    required String name,
    required String document,
    required String email,
    required String description,
    required HipayProcess process,
    required int volumeSetting,
    required int anticipationDaysSetting,
  });

  Future<List<Recipient>> listarRecebedores({required int pageNumber, required int pageSize});

  Future<Recipient> detalharRecebedor({required String receipId});

  Future<BalanceResponse> verificarSaldo({required String receipId});

  Future<String> criarContaBancariaParaRecebedor({required String receipId, required String pixKey, required String agency, required String agencyVerificationDigit, required String bankCode, required String account, required String accountVerificationDigit});

  Future<List<ReceipBankAccount>> listarContasBancariasRecebedor({required String receipId, required int pageNumber, required int pageSize});

  Future<String> criarTransferenciaRecebedor({required String receipId, required int amount, required String bankAccountId, required String idempotencyKey, double? transferFee});

  Future<List<Transfer>> listarTransferenciasRecebor({required String receipId, required int pageNumber, required int pageSize});

  Future<Transfer> detalharTransferenciaRecebedor({required String receipId, required String transferId});

  Future<List<Bank>> getBanks();
}
