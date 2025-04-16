// import 'package:talker/talker.dart';

// class PersistentHistory implements TalkerHistory {
//   PersistentHistory({this.logFilePath = 'logs/app.log'}) {
//     _init();
//   }

//   final String logFilePath;
//   final List<TalkerData> _history = [];

//   File get _logFile => File(logFilePath);

//   Future<void> _init() async {
//     if (!await _logFile.exists()) {
//       await _logFile.create(recursive: true);
//     } else {
//       final lines = await _logFile.readAsLines();
//       for (final line in lines) {
//         try {
//           final json = jsonDecode(line) as Map<String, dynamic>;
//           _history.add(TalkerData());
//         } catch (_) {
//           // Ignora linhas malformadas ou antigas
//         }
//       }
//     }
//   }

//   @override
//   void write(TalkerData data) {
//     _history.add(data);
//     _logFile.writeAsStringSync(
//       jsonEncode(data.toMap()) + '\n',
//       mode: FileMode.append,
//     );
//   }

//   @override
//   void clean() {
//     _history.clear();
//     _logFile.writeAsStringSync('');
//   }

//   @override
//   List<TalkerData> get history => List.unmodifiable(_history);
// }
