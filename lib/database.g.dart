// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WorldCitiesTable extends WorldCities
    with TableInfo<$WorldCitiesTable, WorldCity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorldCitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityAsciiMeta =
      const VerificationMeta('cityAscii');
  @override
  late final GeneratedColumn<String> cityAscii = GeneratedColumn<String>(
      'city_ascii', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
      'lon', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _iso2Meta = const VerificationMeta('iso2');
  @override
  late final GeneratedColumn<String> iso2 = GeneratedColumn<String>(
      'iso2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iso3Meta = const VerificationMeta('iso3');
  @override
  late final GeneratedColumn<String> iso3 = GeneratedColumn<String>(
      'iso3', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [city, cityAscii, state, country, lat, lon, iso2, iso3];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'world_cities';
  @override
  VerificationContext validateIntegrity(Insertable<WorldCity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('city_ascii')) {
      context.handle(_cityAsciiMeta,
          cityAscii.isAcceptableOrUnknown(data['city_ascii']!, _cityAsciiMeta));
    } else if (isInserting) {
      context.missing(_cityAsciiMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
          _lonMeta, lon.isAcceptableOrUnknown(data['lon']!, _lonMeta));
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('iso2')) {
      context.handle(
          _iso2Meta, iso2.isAcceptableOrUnknown(data['iso2']!, _iso2Meta));
    } else if (isInserting) {
      context.missing(_iso2Meta);
    }
    if (data.containsKey('iso3')) {
      context.handle(
          _iso3Meta, iso3.isAcceptableOrUnknown(data['iso3']!, _iso3Meta));
    } else if (isInserting) {
      context.missing(_iso3Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  WorldCity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorldCity(
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      cityAscii: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city_ascii'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      lon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lon'])!,
      iso2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iso2'])!,
      iso3: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iso3'])!,
    );
  }

  @override
  $WorldCitiesTable createAlias(String alias) {
    return $WorldCitiesTable(attachedDatabase, alias);
  }
}

class WorldCity extends DataClass implements Insertable<WorldCity> {
  final String city;
  final String cityAscii;
  final String state;
  final String country;
  final double lat;
  final double lon;
  final String iso2;
  final String iso3;
  const WorldCity(
      {required this.city,
      required this.cityAscii,
      required this.state,
      required this.country,
      required this.lat,
      required this.lon,
      required this.iso2,
      required this.iso3});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['city'] = Variable<String>(city);
    map['city_ascii'] = Variable<String>(cityAscii);
    map['state'] = Variable<String>(state);
    map['country'] = Variable<String>(country);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['iso2'] = Variable<String>(iso2);
    map['iso3'] = Variable<String>(iso3);
    return map;
  }

  WorldCitiesCompanion toCompanion(bool nullToAbsent) {
    return WorldCitiesCompanion(
      city: Value(city),
      cityAscii: Value(cityAscii),
      state: Value(state),
      country: Value(country),
      lat: Value(lat),
      lon: Value(lon),
      iso2: Value(iso2),
      iso3: Value(iso3),
    );
  }

  factory WorldCity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorldCity(
      city: serializer.fromJson<String>(json['city']),
      cityAscii: serializer.fromJson<String>(json['cityAscii']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      iso2: serializer.fromJson<String>(json['iso2']),
      iso3: serializer.fromJson<String>(json['iso3']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'city': serializer.toJson<String>(city),
      'cityAscii': serializer.toJson<String>(cityAscii),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'iso2': serializer.toJson<String>(iso2),
      'iso3': serializer.toJson<String>(iso3),
    };
  }

  WorldCity copyWith(
          {String? city,
          String? cityAscii,
          String? state,
          String? country,
          double? lat,
          double? lon,
          String? iso2,
          String? iso3}) =>
      WorldCity(
        city: city ?? this.city,
        cityAscii: cityAscii ?? this.cityAscii,
        state: state ?? this.state,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        iso2: iso2 ?? this.iso2,
        iso3: iso3 ?? this.iso3,
      );
  @override
  String toString() {
    return (StringBuffer('WorldCity(')
          ..write('city: $city, ')
          ..write('cityAscii: $cityAscii, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('iso2: $iso2, ')
          ..write('iso3: $iso3')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(city, cityAscii, state, country, lat, lon, iso2, iso3);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorldCity &&
          other.city == this.city &&
          other.cityAscii == this.cityAscii &&
          other.state == this.state &&
          other.country == this.country &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.iso2 == this.iso2 &&
          other.iso3 == this.iso3);
}

class WorldCitiesCompanion extends UpdateCompanion<WorldCity> {
  final Value<String> city;
  final Value<String> cityAscii;
  final Value<String> state;
  final Value<String> country;
  final Value<double> lat;
  final Value<double> lon;
  final Value<String> iso2;
  final Value<String> iso3;
  final Value<int> rowid;
  const WorldCitiesCompanion({
    this.city = const Value.absent(),
    this.cityAscii = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.iso2 = const Value.absent(),
    this.iso3 = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorldCitiesCompanion.insert({
    required String city,
    required String cityAscii,
    required String state,
    required String country,
    required double lat,
    required double lon,
    required String iso2,
    required String iso3,
    this.rowid = const Value.absent(),
  })  : city = Value(city),
        cityAscii = Value(cityAscii),
        state = Value(state),
        country = Value(country),
        lat = Value(lat),
        lon = Value(lon),
        iso2 = Value(iso2),
        iso3 = Value(iso3);
  static Insertable<WorldCity> custom({
    Expression<String>? city,
    Expression<String>? cityAscii,
    Expression<String>? state,
    Expression<String>? country,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? iso2,
    Expression<String>? iso3,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (city != null) 'city': city,
      if (cityAscii != null) 'city_ascii': cityAscii,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (iso2 != null) 'iso2': iso2,
      if (iso3 != null) 'iso3': iso3,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorldCitiesCompanion copyWith(
      {Value<String>? city,
      Value<String>? cityAscii,
      Value<String>? state,
      Value<String>? country,
      Value<double>? lat,
      Value<double>? lon,
      Value<String>? iso2,
      Value<String>? iso3,
      Value<int>? rowid}) {
    return WorldCitiesCompanion(
      city: city ?? this.city,
      cityAscii: cityAscii ?? this.cityAscii,
      state: state ?? this.state,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      iso2: iso2 ?? this.iso2,
      iso3: iso3 ?? this.iso3,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (cityAscii.present) {
      map['city_ascii'] = Variable<String>(cityAscii.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (iso2.present) {
      map['iso2'] = Variable<String>(iso2.value);
    }
    if (iso3.present) {
      map['iso3'] = Variable<String>(iso3.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorldCitiesCompanion(')
          ..write('city: $city, ')
          ..write('cityAscii: $cityAscii, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('iso2: $iso2, ')
          ..write('iso3: $iso3, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $WorldCitiesTable worldCities = $WorldCitiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [worldCities];
}

typedef $$WorldCitiesTableInsertCompanionBuilder = WorldCitiesCompanion
    Function({
  required String city,
  required String cityAscii,
  required String state,
  required String country,
  required double lat,
  required double lon,
  required String iso2,
  required String iso3,
  Value<int> rowid,
});
typedef $$WorldCitiesTableUpdateCompanionBuilder = WorldCitiesCompanion
    Function({
  Value<String> city,
  Value<String> cityAscii,
  Value<String> state,
  Value<String> country,
  Value<double> lat,
  Value<double> lon,
  Value<String> iso2,
  Value<String> iso3,
  Value<int> rowid,
});

class $$WorldCitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorldCitiesTable,
    WorldCity,
    $$WorldCitiesTableFilterComposer,
    $$WorldCitiesTableOrderingComposer,
    $$WorldCitiesTableProcessedTableManager,
    $$WorldCitiesTableInsertCompanionBuilder,
    $$WorldCitiesTableUpdateCompanionBuilder> {
  $$WorldCitiesTableTableManager(_$AppDatabase db, $WorldCitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorldCitiesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorldCitiesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorldCitiesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> city = const Value.absent(),
            Value<String> cityAscii = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<double> lat = const Value.absent(),
            Value<double> lon = const Value.absent(),
            Value<String> iso2 = const Value.absent(),
            Value<String> iso3 = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorldCitiesCompanion(
            city: city,
            cityAscii: cityAscii,
            state: state,
            country: country,
            lat: lat,
            lon: lon,
            iso2: iso2,
            iso3: iso3,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String city,
            required String cityAscii,
            required String state,
            required String country,
            required double lat,
            required double lon,
            required String iso2,
            required String iso3,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorldCitiesCompanion.insert(
            city: city,
            cityAscii: cityAscii,
            state: state,
            country: country,
            lat: lat,
            lon: lon,
            iso2: iso2,
            iso3: iso3,
            rowid: rowid,
          ),
        ));
}

class $$WorldCitiesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorldCitiesTable,
    WorldCity,
    $$WorldCitiesTableFilterComposer,
    $$WorldCitiesTableOrderingComposer,
    $$WorldCitiesTableProcessedTableManager,
    $$WorldCitiesTableInsertCompanionBuilder,
    $$WorldCitiesTableUpdateCompanionBuilder> {
  $$WorldCitiesTableProcessedTableManager(super.$state);
}

class $$WorldCitiesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorldCitiesTable> {
  $$WorldCitiesTableFilterComposer(super.$state);
  ColumnFilters<String> get city => $state.composableBuilder(
      column: $state.table.city,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cityAscii => $state.composableBuilder(
      column: $state.table.cityAscii,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get country => $state.composableBuilder(
      column: $state.table.country,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get lat => $state.composableBuilder(
      column: $state.table.lat,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get lon => $state.composableBuilder(
      column: $state.table.lon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get iso2 => $state.composableBuilder(
      column: $state.table.iso2,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get iso3 => $state.composableBuilder(
      column: $state.table.iso3,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WorldCitiesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorldCitiesTable> {
  $$WorldCitiesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get city => $state.composableBuilder(
      column: $state.table.city,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cityAscii => $state.composableBuilder(
      column: $state.table.cityAscii,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get country => $state.composableBuilder(
      column: $state.table.country,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get lat => $state.composableBuilder(
      column: $state.table.lat,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get lon => $state.composableBuilder(
      column: $state.table.lon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get iso2 => $state.composableBuilder(
      column: $state.table.iso2,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get iso3 => $state.composableBuilder(
      column: $state.table.iso3,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$WorldCitiesTableTableManager get worldCities =>
      $$WorldCitiesTableTableManager(_db, _db.worldCities);
}
