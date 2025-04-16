import 'package:talker/talker.dart';

class TalkerLogs {
  static TalkerLogs? _instance;
  // Avoid self instance
  TalkerLogs._();
  static TalkerLogs get instance => _instance ??= TalkerLogs._();

  Talker _talker = Talker(
      settings: TalkerSettings(
    enabled: true,
    useHistory: true,
    maxHistoryItems: 1000,
    useConsoleLogs: true,
  ));

  Talker get talker => _talker;

  void configure({required Talker talker}) {
    _talker = talker;
  }
}
