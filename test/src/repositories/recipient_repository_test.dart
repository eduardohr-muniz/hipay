import 'package:flutter_test/flutter_test.dart';
import 'package:hipay/hipay.dart';

void main() {
  group('RECIPIENT REPOSITORY', () {
    late Hipay hipay;
    setUp(() {
      hipay = Hipay(apiKey: '', enableLogs: true, sandbox: true);
    });
  });
}
