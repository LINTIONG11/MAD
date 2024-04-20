// web.dart
import 'dart:typed_data';
import 'package:budget/database/binary_string_conversion.dart';
import 'package:budget/struct/databaseGlobal.dart';
import 'package:drift/web.dart';
import 'package:budget/database/tables.dart';
import 'package:universal_html/html.dart' as html;

Future<FinanceDatabase> constructDb(String dbName,
    {Uint8List? initialDataWeb}) async {
  if (initialDataWeb != null)
    return FinanceDatabase(
        WebDatabase.withStorage(InMemoryWebStorage(initialDataWeb)));

  return FinanceDatabase(
    WebDatabase.withStorage(
      await DriftWebStorage.indexedDbIfSupported(dbName),
      logStatements: false,
    ),
  );
}

Future<DBFileInfo> getCurrentDBFileInfo() async {
  Uint8List dbFileBytes;
  late Stream<List<int>> mediaStream;
  bool supportIndexedDb = await DriftWebStorage.supportsIndexedDb();

  if (supportIndexedDb) {
    DriftWebStorage storage = await DriftWebStorage.indexedDbIfSupported('db');
    await storage.open();
    dbFileBytes = (await storage.restore()) ?? Uint8List.fromList([]);
    mediaStream = Stream.value(List<int>.from(dbFileBytes));
  } else {
    final html.Storage localStorage = html.window.localStorage;
    dbFileBytes = bin2str.decode(localStorage["moor_db_str_db"] ?? "");
    mediaStream = Stream.value(dbFileBytes);
  }

  return DBFileInfo(dbFileBytes, mediaStream);
}

Future overwriteDefaultDB(Uint8List dataStore) async {
  bool supportIndexedDb = await DriftWebStorage.supportsIndexedDb();
  if (supportIndexedDb) {
    DriftWebStorage storage = await DriftWebStorage.indexedDbIfSupported('db');
    await storage.open();
    await storage.store(dataStore);
  } else {
    final html.Storage localStorage = html.window.localStorage;
    localStorage.clear();
    localStorage["moor_db_str_db"] =
        bin2str.encode(Uint8List.fromList(dataStore));
  }
  
  await sharedPreferences.setString("dateOfLastSyncedWithClient", "{}");
}


class InMemoryWebStorage implements DriftWebStorage {
  Uint8List? _storedData;

  InMemoryWebStorage([Uint8List? initialData]) : _storedData = initialData;

  @override
  Future<void> close() => Future.value();

  @override
  Future<void> open() => Future.value();

  @override
  Future<Uint8List?> restore() => Future.value(_storedData);

  @override
  Future<void> store(Uint8List data) {
    _storedData = data;
    return Future.value();
  }
}


