library hipay;

class Hipay {
  final String apiKey;
  final bool sandbox;
  final bool enableLogs;

  Hipay({required this.apiKey, this.sandbox = false, this.enableLogs = false});
}
