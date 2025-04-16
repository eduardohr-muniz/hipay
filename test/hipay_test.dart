import 'package:flutter_test/flutter_test.dart';
import 'package:hipay/hipay.dart';

void main() {
  const apiKeySandBox = 'sk_bfOespf6Kk6NQdaz1CeyA5wXlQPVfEyY+gtnrE2TkQ';
  const apiKeyProd = 'sk_eTnuKsdumUGGYRgxFJqkGtbtqx1A60eNVK3xtzfzKQ';

  group('CUSTOMERS', () {
    late Hipay hipay;

    setUp(() {
      hipay = Hipay(apiKey: apiKeySandBox, enableLogs: true, sandbox: true);
    });
    test('AO CRIAR UM CLIENTE DEVE RETORNAR O ID', () async {
      final id = await hipay.customers.criarCliente(customer: Customer(name: 'Ana Laura', email: 'ana@gmail', document: Document(number: '12973643686', type: DocumentType.cpf)));
      expect(id, isA<String>());
    });
    test('DEVE RETORNAR O CUSTOMER DETALHADO', () async {
      final result = await hipay.customers.detalharCliente(id: 'cus_c3c7d2cb57004a8a87ff7b06b01c0ebc');
      expect(result, isA<CustomerDetailResponse>());
    });
    test('DEVE RETORNAR UMA LISTA DE CUSTOMERS', () async {
      final result = await hipay.customers.listarClientes(pageNumber: 1, pageSize: 10);
      expect(result, isA<List<Customer>>());
    });
  });

  group('RECIPIENTS', () {
    late Hipay hipay;
    late String receipId;

    setUp(() {
      hipay = Hipay(apiKey: apiKeySandBox, enableLogs: true, sandbox: true);
      receipId = 're_5f7f0ba4caa54e119b7d2a34c1ba6b4d';
    });

    test('DEVE RETORNAR UM CREATE RECEIP RESPONSE', () async {
      final result = await hipay.recipients.criarRecebedor(
        documentType: DocumentType.cpf.name,
        name: 'Edu',
        document: '12973643686',
        email: 'edu@gmail.com',
        description: 'desc teste',
        process: HipayProcess.PerAnticipationDays,
        anticipationDaysSetting: 0,
        volumeSetting: 0,
      );
      expect(result, isA<CreateRecipientResponse>());
    });
    test('DEVE LISTAR OS RECEBEORES', () async {
      final result = await hipay.recipients.listarRecebedores(
        pageNumber: 1,
        pageSize: 20,
      );
      expect(result, isA<List<Recipient>>());
    });
    test('DEVE TRAZER UM RECEBEDOR DETALHADO', () async {
      final result = await hipay.recipients.detalharRecebedor(receipId: receipId);
      expect(result, isA<Recipient>());
    });

    test('DEVE TRAZER UMA LISTAGEM DE BANCOS BRASILEIROS', () async {
      final result = await hipay.recipients.getBanks();
      expect(result, isA<List<Bank>>());
    });
    test('DEVE CRIAR UMA CONTA BANCARIA PARA O RECEBEDOR', () async {
      final result = await hipay.recipients.criarContaBancariaParaRecebedor(receipId: receipId, pixKey: '35984091567', agency: '0001', agencyVerificationDigit: '', bankCode: '260', account: '98643919', accountVerificationDigit: '2');
      expect(result, isA<String>());
    });
    test('DEVE LISTAR AS CONTAS BANCARIAS DO RECEBEDOR', () async {
      final result = await hipay.recipients.listarContasBancariasRecebedor(pageNumber: 1, pageSize: 20, receipId: receipId);
      expect(result, isA<List<ReceipBankAccount>>());
    });
    // test('DEVE CRIAR UMA TRANSFERENCIA DA CONTA DO RECEBEDOR', () async {
    //   final result = await hipay.recipients.criarTransferenciaRecebedor(receipId: receipId, amount: 50, bankAccountId: '', idempotencyKey: '123456789', transferFee: 0.0);
    //   expect(result, isA<List<Transfer>>());
    // });
    test('DEVE TRAZER UM DETALHAMENTO DA TRANSFERENCIA', () async {
      final result = await hipay.recipients.detalharTransferenciaRecebedor(receipId: receipId, transferId: '');
      expect(result, isA<List<Transfer>>());
    });
    test('DEVE LISTAR AS TRANSFERENCIAS DO RECEBEDOR', () async {
      final result = await hipay.recipients.listarTransferenciasRecebor(pageNumber: 1, pageSize: 20, receipId: receipId);
      expect(result, isA<List<Transfer>>());
    });
  });
  group('PRODUCAO', () {
    late Hipay hipay;

    setUp(() {
      hipay = Hipay(apiKey: apiKeyProd, enableLogs: true, sandbox: false);
    });

    test('LISTAR CLIENTES', () async {
      final customers = await hipay.customers.listarClientes(pageNumber: 1, pageSize: 10);
      expect(customers, isA<List<Customer>>());
    });

    test('CRIANDO UMA TRANSACAO SEM SPLIT', () async {
      final result = await hipay.transactions.createTransaction(amount: 100, paymentMethod: HipayPaymentMethod.pix, description: 'Pedio 01', expiresIn: DateTime.now().add(const Duration(hours: 2)), customerId: 'cus_389b223dc7a042609e8ff2f5877a3ab7');
      expect(result, isA<TransactionResponse>());
    });
    test('DETALHAR A TRANSACAO PELO ID SEM SPLIT', () async {
      final result = await hipay.transactions.detalharTransacao(transactionId: 'in_50b0c824d3cd41afab0872daad0cbd3a');
      expect(result, isA<Transaction>());
    });

    test('DEVE REEMBOLSAR A TRANSACAO SEM SPLIT', () async {
      await hipay.transactions.reembolsarTransacao(transactionId: 'in_50b0c824d3cd41afab0872daad0cbd3a');
    });
    test('CRIANDO UMA TRANSACAO COM SPLIT', () async {
      final result = await hipay.transactions.createTransaction(
        amount: 500,
        paymentMethod: HipayPaymentMethod.pix,
        description: 'Pedio 02',
        expiresIn: DateTime.now().add(const Duration(hours: 2)),
        customerId: 'cus_389b223dc7a042609e8ff2f5877a3ab7',
        splits: [
          HipaySplit(
            amount: 450,
            chargeProcessingFee: true,
            liable: true,
            recipientId: 're_aa7619f5ab68484c9a5c0399f4fd7a85',
          ),
          HipaySplit(
            amount: 50,
            chargeProcessingFee: false,
            liable: false,
            recipientId: 're_ff58bfaa64d94b148aa3d3be244dcb74',
          ),
        ],
      );
      expect(result, isA<TransactionResponse>());
    });

    test('DETALHAR A TRANSACAO PELO ID COM SPLIT', () async {
      final result = await hipay.transactions.detalharTransacao(transactionId: 'in_0b5540c0de484eefb8bd814ee9800c7a');
      expect(result, isA<Transaction>());
    });
    test('LISTAR CONTAS BANCARIAS DO RECEBEDOR', () async {
      final result = await hipay.recipients.listarContasBancariasRecebedor(pageNumber: 1, pageSize: 20, receipId: 're_aa7619f5ab68484c9a5c0399f4fd7a85');
      expect(result, isA<List<ReceipBankAccount>>());
    });
    test('DEVE RECEBER O DINHEIRO NA CONTA', () async {
      final result = await hipay.recipients.criarTransferenciaRecebedor(receipId: 're_aa7619f5ab68484c9a5c0399f4fd7a85', amount: 500, bankAccountId: 'ba_4d313d4443c443939ac4cf6835c1b123', idempotencyKey: 'JBASIdsassdsUDHF-JHHIASDV-ASH');
      expect(result, isA<String>());
    });
    test('DEVE DETALHAR A TRANSFERENCIA', () async {
      final result = await hipay.recipients.detalharTransferenciaRecebedor(receipId: 're_aa7619f5ab68484c9a5c0399f4fd7a85', transferId: 'out_feb4c44523bb462c8be73a7cc4c20376');
      expect(result, isA<Transfer>());
    });

    test('LISTAR TODAS AS TRANSACOES DA CONTA PODENDO FILTAR POR STATUS', () async {
      final result = await hipay.transactions.listarTransacoes(pageNumber: 1, pageSize: 20, status: HipayTransactionStatus.paid);
      expect(result, isA<List<Transaction>>());
    });
    test('VERIFICAR SALDO', () async {
      final result = await hipay.recipients.verificarSaldo(receipId: 're_ff58bfaa64d94b148aa3d3be244dcb74');
      expect(result, isA<BalanceResponse>());
    });
  });
}
