import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class WorldCities extends Table {
  TextColumn get city => text()();
  TextColumn get cityAscii => text()();
  TextColumn get state => text()();
  TextColumn get country => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  TextColumn get iso2 => text()();
  TextColumn get iso3 => text()();
}

@DriftDatabase(tables: [WorldCities])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<WorldCity>> getDestinations(String partialString) async {
    final _worldCities = select(worldCities);

    _worldCities.where((tbl) {
      return tbl.country.contains(partialString) |
          tbl.city.contains(partialString) |
          tbl.cityAscii.contains(partialString);
    });

    _worldCities.limit(10);

    return _worldCities.get();
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
      final blob = await rootBundle.load('assets/world_cities.db');
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
