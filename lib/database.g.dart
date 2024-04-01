// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DestinationsTable extends Destinations
    with TableInfo<$DestinationsTable, Destination> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DestinationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
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
  static const VerificationMeta _iso31661_2Meta =
      const VerificationMeta('iso31661_2');
  @override
  late final GeneratedColumn<String> iso31661_2 = GeneratedColumn<String>(
      'iso31661_2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iso31661_3Meta =
      const VerificationMeta('iso31661_3');
  @override
  late final GeneratedColumn<String> iso31661_3 = GeneratedColumn<String>(
      'iso31661_3', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iso31661_numMeta =
      const VerificationMeta('iso31661_num');
  @override
  late final GeneratedColumn<String> iso31661_num = GeneratedColumn<String>(
      'iso31661_num', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, city, country, lat, lon, iso31661_2, iso31661_3, iso31661_num];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'destinations';
  @override
  VerificationContext validateIntegrity(Insertable<Destination> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
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
    if (data.containsKey('iso31661_2')) {
      context.handle(
          _iso31661_2Meta,
          iso31661_2.isAcceptableOrUnknown(
              data['iso31661_2']!, _iso31661_2Meta));
    } else if (isInserting) {
      context.missing(_iso31661_2Meta);
    }
    if (data.containsKey('iso31661_3')) {
      context.handle(
          _iso31661_3Meta,
          iso31661_3.isAcceptableOrUnknown(
              data['iso31661_3']!, _iso31661_3Meta));
    } else if (isInserting) {
      context.missing(_iso31661_3Meta);
    }
    if (data.containsKey('iso31661_num')) {
      context.handle(
          _iso31661_numMeta,
          iso31661_num.isAcceptableOrUnknown(
              data['iso31661_num']!, _iso31661_numMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Destination map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Destination(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      lon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lon'])!,
      iso31661_2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iso31661_2'])!,
      iso31661_3: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iso31661_3'])!,
      iso31661_num: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iso31661_num']),
    );
  }

  @override
  $DestinationsTable createAlias(String alias) {
    return $DestinationsTable(attachedDatabase, alias);
  }
}

class Destination extends DataClass implements Insertable<Destination> {
  final int id;
  final String city;
  final String country;
  final double lat;
  final double lon;
  final String iso31661_2;
  final String iso31661_3;
  final String? iso31661_num;
  const Destination(
      {required this.id,
      required this.city,
      required this.country,
      required this.lat,
      required this.lon,
      required this.iso31661_2,
      required this.iso31661_3,
      this.iso31661_num});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['iso31661_2'] = Variable<String>(iso31661_2);
    map['iso31661_3'] = Variable<String>(iso31661_3);
    if (!nullToAbsent || iso31661_num != null) {
      map['iso31661_num'] = Variable<String>(iso31661_num);
    }
    return map;
  }

  DestinationsCompanion toCompanion(bool nullToAbsent) {
    return DestinationsCompanion(
      id: Value(id),
      city: Value(city),
      country: Value(country),
      lat: Value(lat),
      lon: Value(lon),
      iso31661_2: Value(iso31661_2),
      iso31661_3: Value(iso31661_3),
      iso31661_num: iso31661_num == null && nullToAbsent
          ? const Value.absent()
          : Value(iso31661_num),
    );
  }

  factory Destination.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Destination(
      id: serializer.fromJson<int>(json['id']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      iso31661_2: serializer.fromJson<String>(json['iso31661_2']),
      iso31661_3: serializer.fromJson<String>(json['iso31661_3']),
      iso31661_num: serializer.fromJson<String?>(json['iso31661_num']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'iso31661_2': serializer.toJson<String>(iso31661_2),
      'iso31661_3': serializer.toJson<String>(iso31661_3),
      'iso31661_num': serializer.toJson<String?>(iso31661_num),
    };
  }

  Destination copyWith(
          {int? id,
          String? city,
          String? country,
          double? lat,
          double? lon,
          String? iso31661_2,
          String? iso31661_3,
          Value<String?> iso31661_num = const Value.absent()}) =>
      Destination(
        id: id ?? this.id,
        city: city ?? this.city,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        iso31661_2: iso31661_2 ?? this.iso31661_2,
        iso31661_3: iso31661_3 ?? this.iso31661_3,
        iso31661_num:
            iso31661_num.present ? iso31661_num.value : this.iso31661_num,
      );
  @override
  String toString() {
    return (StringBuffer('Destination(')
          ..write('id: $id, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('iso31661_2: $iso31661_2, ')
          ..write('iso31661_3: $iso31661_3, ')
          ..write('iso31661_num: $iso31661_num')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, city, country, lat, lon, iso31661_2, iso31661_3, iso31661_num);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Destination &&
          other.id == this.id &&
          other.city == this.city &&
          other.country == this.country &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.iso31661_2 == this.iso31661_2 &&
          other.iso31661_3 == this.iso31661_3 &&
          other.iso31661_num == this.iso31661_num);
}

class DestinationsCompanion extends UpdateCompanion<Destination> {
  final Value<int> id;
  final Value<String> city;
  final Value<String> country;
  final Value<double> lat;
  final Value<double> lon;
  final Value<String> iso31661_2;
  final Value<String> iso31661_3;
  final Value<String?> iso31661_num;
  const DestinationsCompanion({
    this.id = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.iso31661_2 = const Value.absent(),
    this.iso31661_3 = const Value.absent(),
    this.iso31661_num = const Value.absent(),
  });
  DestinationsCompanion.insert({
    this.id = const Value.absent(),
    required String city,
    required String country,
    required double lat,
    required double lon,
    required String iso31661_2,
    required String iso31661_3,
    this.iso31661_num = const Value.absent(),
  })  : city = Value(city),
        country = Value(country),
        lat = Value(lat),
        lon = Value(lon),
        iso31661_2 = Value(iso31661_2),
        iso31661_3 = Value(iso31661_3);
  static Insertable<Destination> custom({
    Expression<int>? id,
    Expression<String>? city,
    Expression<String>? country,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? iso31661_2,
    Expression<String>? iso31661_3,
    Expression<String>? iso31661_num,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (iso31661_2 != null) 'iso31661_2': iso31661_2,
      if (iso31661_3 != null) 'iso31661_3': iso31661_3,
      if (iso31661_num != null) 'iso31661_num': iso31661_num,
    });
  }

  DestinationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? city,
      Value<String>? country,
      Value<double>? lat,
      Value<double>? lon,
      Value<String>? iso31661_2,
      Value<String>? iso31661_3,
      Value<String?>? iso31661_num}) {
    return DestinationsCompanion(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      iso31661_2: iso31661_2 ?? this.iso31661_2,
      iso31661_3: iso31661_3 ?? this.iso31661_3,
      iso31661_num: iso31661_num ?? this.iso31661_num,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
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
    if (iso31661_2.present) {
      map['iso31661_2'] = Variable<String>(iso31661_2.value);
    }
    if (iso31661_3.present) {
      map['iso31661_3'] = Variable<String>(iso31661_3.value);
    }
    if (iso31661_num.present) {
      map['iso31661_num'] = Variable<String>(iso31661_num.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DestinationsCompanion(')
          ..write('id: $id, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('iso31661_2: $iso31661_2, ')
          ..write('iso31661_3: $iso31661_3, ')
          ..write('iso31661_num: $iso31661_num')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $DestinationsTable destinations = $DestinationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [destinations];
}
