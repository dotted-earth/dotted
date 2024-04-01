import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class Destinations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get city => text()();
  TextColumn get country => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  TextColumn get iso31661_2 => text()();
  TextColumn get iso31661_3 => text()();
  TextColumn get iso31661_num => text().nullable()();
}

@DriftDatabase(tables: [Destinations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await customStatement('PRAGMA foreign_keys = OFF');
        await transaction(() async {
          // perform migrations
        });

        if (kDebugMode) {
          final wrongForeignKeys =
              await customSelect('PRAGMA foreign_key_check').get();
          assert(wrongForeignKeys.isEmpty,
              '${wrongForeignKeys.map((e) => e.data)}');
        }
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {}

        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<List<Destination>> getDestinations(String partialString) {
    final _destinations = select(destinations);

    _destinations.where((tbl) {
      return tbl.country.contains(partialString) |
          tbl.city.contains(partialString);
    });

    _destinations.limit(10);

    return _destinations.get();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.db'));

    if (!await file.exists()) {
      final blob = await rootBundle.load('assets/destinations.db');
      final buffer = blob.buffer;
      await file.writeAsBytes(
          buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
    }

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
