# Hipay Payments

**A Pix payment platform with the lowest fees in the market.**

### 📄 [Documentation](https://hipay.readme.io)

---

## 🚀 Getting Started

```dart
import 'package:hipay/hipay.dart';

final hipay = Hipay(apiKey: apiKeySandBox, enableLogs: true, sandbox: true);
```

## 💳 Creating a Transaction

```dart
import 'package:hipay/hipay.dart';

final hipay = Hipay(apiKey: apiKeySandBox, enableLogs: true, sandbox: true);

final transaction = await hipay.transactions.createTransaction(
  amount: 500,
  paymentMethod: HipayPaymentMethod.pix,
  description: 'Order 02',
  expiresIn: DateTime.now().add(const Duration(hours: 2)),
  customerId: 'cus_389b223dc7a042609e8ff2f5877a3a',
  splits: [
    HipaySplit(
      amount: 450,
      chargeProcessingFee: true,
      liable: true,
      recipientId: 're_aa7619f5ab68484c9a5c0399f4fd',
    ),
    HipaySplit(
      amount: 50,
      chargeProcessingFee: false,
      liable: false,
      recipientId: 're_ff58bfaa64d94b148aa3d3b4dcb74',
    ),
  ],
);

```
Feel free to reach out if you need more examples or advanced usage!