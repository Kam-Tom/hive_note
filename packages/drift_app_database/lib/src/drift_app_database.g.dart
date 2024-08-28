// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_app_database.dart';

// ignore_for_file: type=lint
class $ApiaryTableTable extends ApiaryTable
    with TableInfo<$ApiaryTableTable, Apiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, latitude, longitude, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apiary_table';
  @override
  VerificationContext validateIntegrity(Insertable<Apiary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Apiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Apiary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ApiaryTableTable createAlias(String alias) {
    return $ApiaryTableTable(attachedDatabase, alias);
  }
}

class ApiaryTableCompanion extends UpdateCompanion<Apiary> {
  final Value<String> id;
  final Value<String> name;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ApiaryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApiaryTableCompanion.insert({
    required String id,
    required String name,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<Apiary> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApiaryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ApiaryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiaryTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QueenTableTable extends QueenTable
    with TableInfo<$QueenTableTable, Queen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueenTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
      'breed', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
      'birth_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isAliveMeta =
      const VerificationMeta('isAlive');
  @override
  late final GeneratedColumn<bool> isAlive = GeneratedColumn<bool>(
      'is_alive', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_alive" IN (0, 1))'),
      defaultValue: Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, breed, origin, birthDate, isAlive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queen_table';
  @override
  VerificationContext validateIntegrity(Insertable<Queen> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
          _breedMeta, breed.isAcceptableOrUnknown(data['breed']!, _breedMeta));
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('is_alive')) {
      context.handle(_isAliveMeta,
          isAlive.isAcceptableOrUnknown(data['is_alive']!, _isAliveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Queen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Queen(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      breed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breed'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      isAlive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_alive'])!,
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birth_date'])!,
    );
  }

  @override
  $QueenTableTable createAlias(String alias) {
    return $QueenTableTable(attachedDatabase, alias);
  }
}

class QueenTableCompanion extends UpdateCompanion<Queen> {
  final Value<String> id;
  final Value<String> breed;
  final Value<String> origin;
  final Value<DateTime> birthDate;
  final Value<bool> isAlive;
  final Value<int> rowid;
  const QueenTableCompanion({
    this.id = const Value.absent(),
    this.breed = const Value.absent(),
    this.origin = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.isAlive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QueenTableCompanion.insert({
    required String id,
    required String breed,
    required String origin,
    required DateTime birthDate,
    this.isAlive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        breed = Value(breed),
        origin = Value(origin),
        birthDate = Value(birthDate);
  static Insertable<Queen> custom({
    Expression<String>? id,
    Expression<String>? breed,
    Expression<String>? origin,
    Expression<DateTime>? birthDate,
    Expression<bool>? isAlive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (breed != null) 'breed': breed,
      if (origin != null) 'origin': origin,
      if (birthDate != null) 'birth_date': birthDate,
      if (isAlive != null) 'is_alive': isAlive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QueenTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? breed,
      Value<String>? origin,
      Value<DateTime>? birthDate,
      Value<bool>? isAlive,
      Value<int>? rowid}) {
    return QueenTableCompanion(
      id: id ?? this.id,
      breed: breed ?? this.breed,
      origin: origin ?? this.origin,
      birthDate: birthDate ?? this.birthDate,
      isAlive: isAlive ?? this.isAlive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (isAlive.present) {
      map['is_alive'] = Variable<bool>(isAlive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueenTableCompanion(')
          ..write('id: $id, ')
          ..write('breed: $breed, ')
          ..write('origin: $origin, ')
          ..write('birthDate: $birthDate, ')
          ..write('isAlive: $isAlive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HiveTableTable extends HiveTable with TableInfo<$HiveTableTable, Hive> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HiveTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _queenIdMeta =
      const VerificationMeta('queenId');
  @override
  late final GeneratedColumn<String> queenId = GeneratedColumn<String>(
      'queen_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES queen_table (id)'));
  static const VerificationMeta _apiaryIdMeta =
      const VerificationMeta('apiaryId');
  @override
  late final GeneratedColumn<String> apiaryId = GeneratedColumn<String>(
      'apiary_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES apiary_table (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, order, type, queenId, apiaryId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hive_table';
  @override
  VerificationContext validateIntegrity(Insertable<Hive> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('queen_id')) {
      context.handle(_queenIdMeta,
          queenId.isAcceptableOrUnknown(data['queen_id']!, _queenIdMeta));
    }
    if (data.containsKey('apiary_id')) {
      context.handle(_apiaryIdMeta,
          apiaryId.isAcceptableOrUnknown(data['apiary_id']!, _apiaryIdMeta));
    } else if (isInserting) {
      context.missing(_apiaryIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hive map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hive(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      queenId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}queen_id']),
      apiaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apiary_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HiveTableTable createAlias(String alias) {
    return $HiveTableTable(attachedDatabase, alias);
  }
}

class HiveTableCompanion extends UpdateCompanion<Hive> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> order;
  final Value<String> type;
  final Value<String?> queenId;
  final Value<String> apiaryId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HiveTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.order = const Value.absent(),
    this.type = const Value.absent(),
    this.queenId = const Value.absent(),
    this.apiaryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HiveTableCompanion.insert({
    required String id,
    required String name,
    required int order,
    required String type,
    this.queenId = const Value.absent(),
    required String apiaryId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        order = Value(order),
        type = Value(type),
        apiaryId = Value(apiaryId),
        createdAt = Value(createdAt);
  static Insertable<Hive> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? order,
    Expression<String>? type,
    Expression<String>? queenId,
    Expression<String>? apiaryId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (order != null) 'order': order,
      if (type != null) 'type': type,
      if (queenId != null) 'queen_id': queenId,
      if (apiaryId != null) 'apiary_id': apiaryId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HiveTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? order,
      Value<String>? type,
      Value<String?>? queenId,
      Value<String>? apiaryId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return HiveTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      type: type ?? this.type,
      queenId: queenId ?? this.queenId,
      apiaryId: apiaryId ?? this.apiaryId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (queenId.present) {
      map['queen_id'] = Variable<String>(queenId.value);
    }
    if (apiaryId.present) {
      map['apiary_id'] = Variable<String>(apiaryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HiveTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('order: $order, ')
          ..write('type: $type, ')
          ..write('queenId: $queenId, ')
          ..write('apiaryId: $apiaryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RaportTableTable extends RaportTable
    with TableInfo<$RaportTableTable, Raport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RaportTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hiveIdMeta = const VerificationMeta('hiveId');
  @override
  late final GeneratedColumn<String> hiveId = GeneratedColumn<String>(
      'hive_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES hive_table (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, hiveId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raport_table';
  @override
  VerificationContext validateIntegrity(Insertable<Raport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hive_id')) {
      context.handle(_hiveIdMeta,
          hiveId.isAcceptableOrUnknown(data['hive_id']!, _hiveIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Raport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Raport(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      hiveId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hive_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RaportTableTable createAlias(String alias) {
    return $RaportTableTable(attachedDatabase, alias);
  }
}

class RaportTableCompanion extends UpdateCompanion<Raport> {
  final Value<String> id;
  final Value<String?> hiveId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RaportTableCompanion({
    this.id = const Value.absent(),
    this.hiveId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RaportTableCompanion.insert({
    required String id,
    this.hiveId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt);
  static Insertable<Raport> custom({
    Expression<String>? id,
    Expression<String>? hiveId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hiveId != null) 'hive_id': hiveId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RaportTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? hiveId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return RaportTableCompanion(
      id: id ?? this.id,
      hiveId: hiveId ?? this.hiveId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hiveId.present) {
      map['hive_id'] = Variable<String>(hiveId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RaportTableCompanion(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntryMetadataTableTable extends EntryMetadataTable
    with TableInfo<$EntryMetadataTableTable, EntryMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _hintMeta = const VerificationMeta('hint');
  @override
  late final GeneratedColumn<String> hint = GeneratedColumn<String>(
      'hint', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _valueTypeMeta =
      const VerificationMeta('valueType');
  @override
  late final GeneratedColumnWithTypeConverter<EntryType, int> valueType =
      GeneratedColumn<int>('value_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<EntryType>(
              $EntryMetadataTableTable.$convertervalueType);
  static const VerificationMeta _raportTypeMeta =
      const VerificationMeta('raportType');
  @override
  late final GeneratedColumnWithTypeConverter<RaportType, int> raportType =
      GeneratedColumn<int>('raport_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RaportType>(
              $EntryMetadataTableTable.$converterraportType);
  @override
  List<GeneratedColumn> get $columns =>
      [id, label, hint, valueType, raportType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_metadata_table';
  @override
  VerificationContext validateIntegrity(Insertable<EntryMetadata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('hint')) {
      context.handle(
          _hintMeta, hint.isAcceptableOrUnknown(data['hint']!, _hintMeta));
    } else if (isInserting) {
      context.missing(_hintMeta);
    }
    context.handle(_valueTypeMeta, const VerificationResult.success());
    context.handle(_raportTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryMetadata(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      hint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hint'])!,
      valueType: $EntryMetadataTableTable.$convertervalueType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}value_type'])!),
      raportType: $EntryMetadataTableTable.$converterraportType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}raport_type'])!),
    );
  }

  @override
  $EntryMetadataTableTable createAlias(String alias) {
    return $EntryMetadataTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EntryType, int, int> $convertervalueType =
      const EnumIndexConverter<EntryType>(EntryType.values);
  static JsonTypeConverter2<RaportType, int, int> $converterraportType =
      const EnumIndexConverter<RaportType>(RaportType.values);
}

class EntryMetadataTableCompanion extends UpdateCompanion<EntryMetadata> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> hint;
  final Value<EntryType> valueType;
  final Value<RaportType> raportType;
  final Value<int> rowid;
  const EntryMetadataTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.hint = const Value.absent(),
    this.valueType = const Value.absent(),
    this.raportType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryMetadataTableCompanion.insert({
    required String id,
    required String label,
    required String hint,
    required EntryType valueType,
    required RaportType raportType,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        label = Value(label),
        hint = Value(hint),
        valueType = Value(valueType),
        raportType = Value(raportType);
  static Insertable<EntryMetadata> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? hint,
    Expression<int>? valueType,
    Expression<int>? raportType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (hint != null) 'hint': hint,
      if (valueType != null) 'value_type': valueType,
      if (raportType != null) 'raport_type': raportType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryMetadataTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<String>? hint,
      Value<EntryType>? valueType,
      Value<RaportType>? raportType,
      Value<int>? rowid}) {
    return EntryMetadataTableCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      hint: hint ?? this.hint,
      valueType: valueType ?? this.valueType,
      raportType: raportType ?? this.raportType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (hint.present) {
      map['hint'] = Variable<String>(hint.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<int>(
          $EntryMetadataTableTable.$convertervalueType.toSql(valueType.value));
    }
    if (raportType.present) {
      map['raport_type'] = Variable<int>($EntryMetadataTableTable
          .$converterraportType
          .toSql(raportType.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryMetadataTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('hint: $hint, ')
          ..write('valueType: $valueType, ')
          ..write('raportType: $raportType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BooleanEntryTableTable extends BooleanEntryTable
    with TableInfo<$BooleanEntryTableTable, BooleanEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooleanEntryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _raportIdMeta =
      const VerificationMeta('raportId');
  @override
  late final GeneratedColumn<String> raportId = GeneratedColumn<String>(
      'raport_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES raport_table (id)'));
  static const VerificationMeta _entryMetadataIdMeta =
      const VerificationMeta('entryMetadataId');
  @override
  late final GeneratedColumn<String> entryMetadataId = GeneratedColumn<String>(
      'entry_metadata_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entry_metadata_table (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<bool> value = GeneratedColumn<bool>(
      'value', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("value" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, raportId, entryMetadataId, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'boolean_entry_table';
  @override
  VerificationContext validateIntegrity(Insertable<BooleanEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raport_id')) {
      context.handle(_raportIdMeta,
          raportId.isAcceptableOrUnknown(data['raport_id']!, _raportIdMeta));
    } else if (isInserting) {
      context.missing(_raportIdMeta);
    }
    if (data.containsKey('entry_metadata_id')) {
      context.handle(
          _entryMetadataIdMeta,
          entryMetadataId.isAcceptableOrUnknown(
              data['entry_metadata_id']!, _entryMetadataIdMeta));
    } else if (isInserting) {
      context.missing(_entryMetadataIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BooleanEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BooleanEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      raportId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raport_id'])!,
      entryMetadataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}entry_metadata_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $BooleanEntryTableTable createAlias(String alias) {
    return $BooleanEntryTableTable(attachedDatabase, alias);
  }
}

class BooleanEntryTableCompanion extends UpdateCompanion<BooleanEntry> {
  final Value<String> id;
  final Value<String> raportId;
  final Value<String> entryMetadataId;
  final Value<bool> value;
  final Value<int> rowid;
  const BooleanEntryTableCompanion({
    this.id = const Value.absent(),
    this.raportId = const Value.absent(),
    this.entryMetadataId = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooleanEntryTableCompanion.insert({
    required String id,
    required String raportId,
    required String entryMetadataId,
    required bool value,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        raportId = Value(raportId),
        entryMetadataId = Value(entryMetadataId),
        value = Value(value);
  static Insertable<BooleanEntry> custom({
    Expression<String>? id,
    Expression<String>? raportId,
    Expression<String>? entryMetadataId,
    Expression<bool>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (raportId != null) 'raport_id': raportId,
      if (entryMetadataId != null) 'entry_metadata_id': entryMetadataId,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooleanEntryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? raportId,
      Value<String>? entryMetadataId,
      Value<bool>? value,
      Value<int>? rowid}) {
    return BooleanEntryTableCompanion(
      id: id ?? this.id,
      raportId: raportId ?? this.raportId,
      entryMetadataId: entryMetadataId ?? this.entryMetadataId,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (raportId.present) {
      map['raport_id'] = Variable<String>(raportId.value);
    }
    if (entryMetadataId.present) {
      map['entry_metadata_id'] = Variable<String>(entryMetadataId.value);
    }
    if (value.present) {
      map['value'] = Variable<bool>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooleanEntryTableCompanion(')
          ..write('id: $id, ')
          ..write('raportId: $raportId, ')
          ..write('entryMetadataId: $entryMetadataId, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TextEntryTableTable extends TextEntryTable
    with TableInfo<$TextEntryTableTable, TextEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TextEntryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _raportIdMeta =
      const VerificationMeta('raportId');
  @override
  late final GeneratedColumn<String> raportId = GeneratedColumn<String>(
      'raport_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES raport_table (id)'));
  static const VerificationMeta _entryMetadataIdMeta =
      const VerificationMeta('entryMetadataId');
  @override
  late final GeneratedColumn<String> entryMetadataId = GeneratedColumn<String>(
      'entry_metadata_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entry_metadata_table (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, raportId, entryMetadataId, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'text_entry_table';
  @override
  VerificationContext validateIntegrity(Insertable<TextEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raport_id')) {
      context.handle(_raportIdMeta,
          raportId.isAcceptableOrUnknown(data['raport_id']!, _raportIdMeta));
    } else if (isInserting) {
      context.missing(_raportIdMeta);
    }
    if (data.containsKey('entry_metadata_id')) {
      context.handle(
          _entryMetadataIdMeta,
          entryMetadataId.isAcceptableOrUnknown(
              data['entry_metadata_id']!, _entryMetadataIdMeta));
    } else if (isInserting) {
      context.missing(_entryMetadataIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TextEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TextEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      raportId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raport_id'])!,
      entryMetadataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}entry_metadata_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $TextEntryTableTable createAlias(String alias) {
    return $TextEntryTableTable(attachedDatabase, alias);
  }
}

class TextEntryTableCompanion extends UpdateCompanion<TextEntry> {
  final Value<String> id;
  final Value<String> raportId;
  final Value<String> entryMetadataId;
  final Value<String> value;
  final Value<int> rowid;
  const TextEntryTableCompanion({
    this.id = const Value.absent(),
    this.raportId = const Value.absent(),
    this.entryMetadataId = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TextEntryTableCompanion.insert({
    required String id,
    required String raportId,
    required String entryMetadataId,
    required String value,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        raportId = Value(raportId),
        entryMetadataId = Value(entryMetadataId),
        value = Value(value);
  static Insertable<TextEntry> custom({
    Expression<String>? id,
    Expression<String>? raportId,
    Expression<String>? entryMetadataId,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (raportId != null) 'raport_id': raportId,
      if (entryMetadataId != null) 'entry_metadata_id': entryMetadataId,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TextEntryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? raportId,
      Value<String>? entryMetadataId,
      Value<String>? value,
      Value<int>? rowid}) {
    return TextEntryTableCompanion(
      id: id ?? this.id,
      raportId: raportId ?? this.raportId,
      entryMetadataId: entryMetadataId ?? this.entryMetadataId,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (raportId.present) {
      map['raport_id'] = Variable<String>(raportId.value);
    }
    if (entryMetadataId.present) {
      map['entry_metadata_id'] = Variable<String>(entryMetadataId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextEntryTableCompanion(')
          ..write('id: $id, ')
          ..write('raportId: $raportId, ')
          ..write('entryMetadataId: $entryMetadataId, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NumericEntryTableTable extends NumericEntryTable
    with TableInfo<$NumericEntryTableTable, NumericEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumericEntryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _raportIdMeta =
      const VerificationMeta('raportId');
  @override
  late final GeneratedColumn<String> raportId = GeneratedColumn<String>(
      'raport_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES raport_table (id)'));
  static const VerificationMeta _entryMetadataIdMeta =
      const VerificationMeta('entryMetadataId');
  @override
  late final GeneratedColumn<String> entryMetadataId = GeneratedColumn<String>(
      'entry_metadata_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES entry_metadata_table (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, raportId, entryMetadataId, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'numeric_entry_table';
  @override
  VerificationContext validateIntegrity(Insertable<NumericEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raport_id')) {
      context.handle(_raportIdMeta,
          raportId.isAcceptableOrUnknown(data['raport_id']!, _raportIdMeta));
    } else if (isInserting) {
      context.missing(_raportIdMeta);
    }
    if (data.containsKey('entry_metadata_id')) {
      context.handle(
          _entryMetadataIdMeta,
          entryMetadataId.isAcceptableOrUnknown(
              data['entry_metadata_id']!, _entryMetadataIdMeta));
    } else if (isInserting) {
      context.missing(_entryMetadataIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NumericEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NumericEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      raportId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raport_id'])!,
      entryMetadataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}entry_metadata_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $NumericEntryTableTable createAlias(String alias) {
    return $NumericEntryTableTable(attachedDatabase, alias);
  }
}

class NumericEntryTableCompanion extends UpdateCompanion<NumericEntry> {
  final Value<String> id;
  final Value<String> raportId;
  final Value<String> entryMetadataId;
  final Value<double> value;
  final Value<int> rowid;
  const NumericEntryTableCompanion({
    this.id = const Value.absent(),
    this.raportId = const Value.absent(),
    this.entryMetadataId = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NumericEntryTableCompanion.insert({
    required String id,
    required String raportId,
    required String entryMetadataId,
    required double value,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        raportId = Value(raportId),
        entryMetadataId = Value(entryMetadataId),
        value = Value(value);
  static Insertable<NumericEntry> custom({
    Expression<String>? id,
    Expression<String>? raportId,
    Expression<String>? entryMetadataId,
    Expression<double>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (raportId != null) 'raport_id': raportId,
      if (entryMetadataId != null) 'entry_metadata_id': entryMetadataId,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NumericEntryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? raportId,
      Value<String>? entryMetadataId,
      Value<double>? value,
      Value<int>? rowid}) {
    return NumericEntryTableCompanion(
      id: id ?? this.id,
      raportId: raportId ?? this.raportId,
      entryMetadataId: entryMetadataId ?? this.entryMetadataId,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (raportId.present) {
      map['raport_id'] = Variable<String>(raportId.value);
    }
    if (entryMetadataId.present) {
      map['entry_metadata_id'] = Variable<String>(entryMetadataId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NumericEntryTableCompanion(')
          ..write('id: $id, ')
          ..write('raportId: $raportId, ')
          ..write('entryMetadataId: $entryMetadataId, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TodoTableTable extends TodoTable with TableInfo<$TodoTableTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryTypeMeta =
      const VerificationMeta('categoryType');
  @override
  late final GeneratedColumnWithTypeConverter<CategoryType, int> categoryType =
      GeneratedColumn<int>('category_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CategoryType>($TodoTableTable.$convertercategoryType);
  static const VerificationMeta _dueToMeta = const VerificationMeta('dueTo');
  @override
  late final GeneratedColumn<DateTime> dueTo = GeneratedColumn<DateTime>(
      'due_to', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, location, description, categoryType, dueTo, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    context.handle(_categoryTypeMeta, const VerificationResult.success());
    if (data.containsKey('due_to')) {
      context.handle(
          _dueToMeta, dueTo.isAcceptableOrUnknown(data['due_to']!, _dueToMeta));
    } else if (isInserting) {
      context.missing(_dueToMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      categoryType: $TodoTableTable.$convertercategoryType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}category_type'])!),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      dueTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_to'])!,
    );
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryType, int, int> $convertercategoryType =
      const EnumIndexConverter<CategoryType>(CategoryType.values);
}

class TodoTableCompanion extends UpdateCompanion<Todo> {
  final Value<String> id;
  final Value<String> location;
  final Value<String> description;
  final Value<CategoryType> categoryType;
  final Value<DateTime> dueTo;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.location = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryType = const Value.absent(),
    this.dueTo = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodoTableCompanion.insert({
    required String id,
    required String location,
    required String description,
    required CategoryType categoryType,
    required DateTime dueTo,
    required bool isCompleted,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        location = Value(location),
        description = Value(description),
        categoryType = Value(categoryType),
        dueTo = Value(dueTo),
        isCompleted = Value(isCompleted);
  static Insertable<Todo> custom({
    Expression<String>? id,
    Expression<String>? location,
    Expression<String>? description,
    Expression<int>? categoryType,
    Expression<DateTime>? dueTo,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (categoryType != null) 'category_type': categoryType,
      if (dueTo != null) 'due_to': dueTo,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodoTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? location,
      Value<String>? description,
      Value<CategoryType>? categoryType,
      Value<DateTime>? dueTo,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      location: location ?? this.location,
      description: description ?? this.description,
      categoryType: categoryType ?? this.categoryType,
      dueTo: dueTo ?? this.dueTo,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryType.present) {
      map['category_type'] = Variable<int>(
          $TodoTableTable.$convertercategoryType.toSql(categoryType.value));
    }
    if (dueTo.present) {
      map['due_to'] = Variable<DateTime>(dueTo.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('categoryType: $categoryType, ')
          ..write('dueTo: $dueTo, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistoryLogTableTable extends HistoryLogTable
    with TableInfo<$HistoryLogTableTable, HistoryLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tableTypeMeta =
      const VerificationMeta('tableType');
  @override
  late final GeneratedColumnWithTypeConverter<TableType, int> tableType =
      GeneratedColumn<int>('table_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TableType>($HistoryLogTableTable.$convertertableType);
  static const VerificationMeta _actionTypeMeta =
      const VerificationMeta('actionType');
  @override
  late final GeneratedColumnWithTypeConverter<ActionType, int> actionType =
      GeneratedColumn<int>('action_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ActionType>(
              $HistoryLogTableTable.$converteractionType);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, referenceId, tableType, actionType, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_log_table';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    } else if (isInserting) {
      context.missing(_referenceIdMeta);
    }
    context.handle(_tableTypeMeta, const VerificationResult.success());
    context.handle(_actionTypeMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id'])!,
      tableType: $HistoryLogTableTable.$convertertableType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}table_type'])!),
      actionType: $HistoryLogTableTable.$converteractionType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}action_type'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HistoryLogTableTable createAlias(String alias) {
    return $HistoryLogTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TableType, int, int> $convertertableType =
      const EnumIndexConverter<TableType>(TableType.values);
  static JsonTypeConverter2<ActionType, int, int> $converteractionType =
      const EnumIndexConverter<ActionType>(ActionType.values);
}

class HistoryLogTableCompanion extends UpdateCompanion<HistoryLog> {
  final Value<String> id;
  final Value<String> referenceId;
  final Value<TableType> tableType;
  final Value<ActionType> actionType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HistoryLogTableCompanion({
    this.id = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.tableType = const Value.absent(),
    this.actionType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistoryLogTableCompanion.insert({
    required String id,
    required String referenceId,
    required TableType tableType,
    required ActionType actionType,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        referenceId = Value(referenceId),
        tableType = Value(tableType),
        actionType = Value(actionType),
        createdAt = Value(createdAt);
  static Insertable<HistoryLog> custom({
    Expression<String>? id,
    Expression<String>? referenceId,
    Expression<int>? tableType,
    Expression<int>? actionType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (referenceId != null) 'reference_id': referenceId,
      if (tableType != null) 'table_type': tableType,
      if (actionType != null) 'action_type': actionType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistoryLogTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? referenceId,
      Value<TableType>? tableType,
      Value<ActionType>? actionType,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return HistoryLogTableCompanion(
      id: id ?? this.id,
      referenceId: referenceId ?? this.referenceId,
      tableType: tableType ?? this.tableType,
      actionType: actionType ?? this.actionType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (tableType.present) {
      map['table_type'] = Variable<int>(
          $HistoryLogTableTable.$convertertableType.toSql(tableType.value));
    }
    if (actionType.present) {
      map['action_type'] = Variable<int>(
          $HistoryLogTableTable.$converteractionType.toSql(actionType.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryLogTableCompanion(')
          ..write('id: $id, ')
          ..write('referenceId: $referenceId, ')
          ..write('tableType: $tableType, ')
          ..write('actionType: $actionType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftAppDatabase extends GeneratedDatabase {
  _$DriftAppDatabase(QueryExecutor e) : super(e);
  $DriftAppDatabaseManager get managers => $DriftAppDatabaseManager(this);
  late final $ApiaryTableTable apiaryTable = $ApiaryTableTable(this);
  late final $QueenTableTable queenTable = $QueenTableTable(this);
  late final $HiveTableTable hiveTable = $HiveTableTable(this);
  late final $RaportTableTable raportTable = $RaportTableTable(this);
  late final $EntryMetadataTableTable entryMetadataTable =
      $EntryMetadataTableTable(this);
  late final $BooleanEntryTableTable booleanEntryTable =
      $BooleanEntryTableTable(this);
  late final $TextEntryTableTable textEntryTable = $TextEntryTableTable(this);
  late final $NumericEntryTableTable numericEntryTable =
      $NumericEntryTableTable(this);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  late final $HistoryLogTableTable historyLogTable =
      $HistoryLogTableTable(this);
  late final ApiaryDao apiaryDao = ApiaryDao(this as DriftAppDatabase);
  late final HiveDao hiveDao = HiveDao(this as DriftAppDatabase);
  late final TodoDao todoDao = TodoDao(this as DriftAppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        apiaryTable,
        queenTable,
        hiveTable,
        raportTable,
        entryMetadataTable,
        booleanEntryTable,
        textEntryTable,
        numericEntryTable,
        todoTable,
        historyLogTable
      ];
}

typedef $$ApiaryTableTableCreateCompanionBuilder = ApiaryTableCompanion
    Function({
  required String id,
  required String name,
  Value<double?> latitude,
  Value<double?> longitude,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ApiaryTableTableUpdateCompanionBuilder = ApiaryTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ApiaryTableTableReferences
    extends BaseReferences<_$DriftAppDatabase, $ApiaryTableTable, Apiary> {
  $$ApiaryTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HiveTableTable, List<Hive>> _hiveTableRefsTable(
          _$DriftAppDatabase db) =>
      MultiTypedResultKey.fromTable(db.hiveTable,
          aliasName:
              $_aliasNameGenerator(db.apiaryTable.id, db.hiveTable.apiaryId));

  $$HiveTableTableProcessedTableManager get hiveTableRefs {
    final manager = $$HiveTableTableTableManager($_db, $_db.hiveTable)
        .filter((f) => f.apiaryId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_hiveTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ApiaryTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $ApiaryTableTable> {
  $$ApiaryTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter hiveTableRefs(
      ComposableFilter Function($$HiveTableTableFilterComposer f) f) {
    final $$HiveTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.hiveTable,
        getReferencedColumn: (t) => t.apiaryId,
        builder: (joinBuilder, parentComposers) =>
            $$HiveTableTableFilterComposer(ComposerState(
                $state.db, $state.db.hiveTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ApiaryTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $ApiaryTableTable> {
  $$ApiaryTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ApiaryTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $ApiaryTableTable,
    Apiary,
    $$ApiaryTableTableFilterComposer,
    $$ApiaryTableTableOrderingComposer,
    $$ApiaryTableTableCreateCompanionBuilder,
    $$ApiaryTableTableUpdateCompanionBuilder,
    (Apiary, $$ApiaryTableTableReferences),
    Apiary,
    PrefetchHooks Function({bool hiveTableRefs})> {
  $$ApiaryTableTableTableManager(_$DriftAppDatabase db, $ApiaryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ApiaryTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ApiaryTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ApiaryTableCompanion(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ApiaryTableCompanion.insert(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ApiaryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({hiveTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (hiveTableRefs) db.hiveTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (hiveTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ApiaryTableTableReferences
                            ._hiveTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ApiaryTableTableReferences(db, table, p0)
                                .hiveTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.apiaryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ApiaryTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $ApiaryTableTable,
    Apiary,
    $$ApiaryTableTableFilterComposer,
    $$ApiaryTableTableOrderingComposer,
    $$ApiaryTableTableCreateCompanionBuilder,
    $$ApiaryTableTableUpdateCompanionBuilder,
    (Apiary, $$ApiaryTableTableReferences),
    Apiary,
    PrefetchHooks Function({bool hiveTableRefs})>;
typedef $$QueenTableTableCreateCompanionBuilder = QueenTableCompanion Function({
  required String id,
  required String breed,
  required String origin,
  required DateTime birthDate,
  Value<bool> isAlive,
  Value<int> rowid,
});
typedef $$QueenTableTableUpdateCompanionBuilder = QueenTableCompanion Function({
  Value<String> id,
  Value<String> breed,
  Value<String> origin,
  Value<DateTime> birthDate,
  Value<bool> isAlive,
  Value<int> rowid,
});

final class $$QueenTableTableReferences
    extends BaseReferences<_$DriftAppDatabase, $QueenTableTable, Queen> {
  $$QueenTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HiveTableTable, List<Hive>> _hiveTableRefsTable(
          _$DriftAppDatabase db) =>
      MultiTypedResultKey.fromTable(db.hiveTable,
          aliasName:
              $_aliasNameGenerator(db.queenTable.id, db.hiveTable.queenId));

  $$HiveTableTableProcessedTableManager get hiveTableRefs {
    final manager = $$HiveTableTableTableManager($_db, $_db.hiveTable)
        .filter((f) => f.queenId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_hiveTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QueenTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $QueenTableTable> {
  $$QueenTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get breed => $state.composableBuilder(
      column: $state.table.breed,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get origin => $state.composableBuilder(
      column: $state.table.origin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get birthDate => $state.composableBuilder(
      column: $state.table.birthDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isAlive => $state.composableBuilder(
      column: $state.table.isAlive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter hiveTableRefs(
      ComposableFilter Function($$HiveTableTableFilterComposer f) f) {
    final $$HiveTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.hiveTable,
        getReferencedColumn: (t) => t.queenId,
        builder: (joinBuilder, parentComposers) =>
            $$HiveTableTableFilterComposer(ComposerState(
                $state.db, $state.db.hiveTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$QueenTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $QueenTableTable> {
  $$QueenTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get breed => $state.composableBuilder(
      column: $state.table.breed,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get origin => $state.composableBuilder(
      column: $state.table.origin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get birthDate => $state.composableBuilder(
      column: $state.table.birthDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isAlive => $state.composableBuilder(
      column: $state.table.isAlive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$QueenTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $QueenTableTable,
    Queen,
    $$QueenTableTableFilterComposer,
    $$QueenTableTableOrderingComposer,
    $$QueenTableTableCreateCompanionBuilder,
    $$QueenTableTableUpdateCompanionBuilder,
    (Queen, $$QueenTableTableReferences),
    Queen,
    PrefetchHooks Function({bool hiveTableRefs})> {
  $$QueenTableTableTableManager(_$DriftAppDatabase db, $QueenTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QueenTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QueenTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> breed = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<DateTime> birthDate = const Value.absent(),
            Value<bool> isAlive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QueenTableCompanion(
            id: id,
            breed: breed,
            origin: origin,
            birthDate: birthDate,
            isAlive: isAlive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String breed,
            required String origin,
            required DateTime birthDate,
            Value<bool> isAlive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QueenTableCompanion.insert(
            id: id,
            breed: breed,
            origin: origin,
            birthDate: birthDate,
            isAlive: isAlive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$QueenTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({hiveTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (hiveTableRefs) db.hiveTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (hiveTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$QueenTableTableReferences._hiveTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QueenTableTableReferences(db, table, p0)
                                .hiveTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.queenId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QueenTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $QueenTableTable,
    Queen,
    $$QueenTableTableFilterComposer,
    $$QueenTableTableOrderingComposer,
    $$QueenTableTableCreateCompanionBuilder,
    $$QueenTableTableUpdateCompanionBuilder,
    (Queen, $$QueenTableTableReferences),
    Queen,
    PrefetchHooks Function({bool hiveTableRefs})>;
typedef $$HiveTableTableCreateCompanionBuilder = HiveTableCompanion Function({
  required String id,
  required String name,
  required int order,
  required String type,
  Value<String?> queenId,
  required String apiaryId,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$HiveTableTableUpdateCompanionBuilder = HiveTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> order,
  Value<String> type,
  Value<String?> queenId,
  Value<String> apiaryId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HiveTableTableReferences
    extends BaseReferences<_$DriftAppDatabase, $HiveTableTable, Hive> {
  $$HiveTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QueenTableTable _queenIdTable(_$DriftAppDatabase db) =>
      db.queenTable.createAlias(
          $_aliasNameGenerator(db.hiveTable.queenId, db.queenTable.id));

  $$QueenTableTableProcessedTableManager? get queenId {
    if ($_item.queenId == null) return null;
    final manager = $$QueenTableTableTableManager($_db, $_db.queenTable)
        .filter((f) => f.id($_item.queenId!));
    final item = $_typedResult.readTableOrNull(_queenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ApiaryTableTable _apiaryIdTable(_$DriftAppDatabase db) =>
      db.apiaryTable.createAlias(
          $_aliasNameGenerator(db.hiveTable.apiaryId, db.apiaryTable.id));

  $$ApiaryTableTableProcessedTableManager? get apiaryId {
    if ($_item.apiaryId == null) return null;
    final manager = $$ApiaryTableTableTableManager($_db, $_db.apiaryTable)
        .filter((f) => f.id($_item.apiaryId!));
    final item = $_typedResult.readTableOrNull(_apiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RaportTableTable, List<Raport>>
      _raportTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.raportTable,
              aliasName:
                  $_aliasNameGenerator(db.hiveTable.id, db.raportTable.hiveId));

  $$RaportTableTableProcessedTableManager get raportTableRefs {
    final manager = $$RaportTableTableTableManager($_db, $_db.raportTable)
        .filter((f) => f.hiveId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_raportTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HiveTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $HiveTableTable> {
  $$HiveTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get order => $state.composableBuilder(
      column: $state.table.order,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$QueenTableTableFilterComposer get queenId {
    final $$QueenTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.queenId,
        referencedTable: $state.db.queenTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$QueenTableTableFilterComposer(ComposerState($state.db,
                $state.db.queenTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$ApiaryTableTableFilterComposer get apiaryId {
    final $$ApiaryTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.apiaryId,
        referencedTable: $state.db.apiaryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ApiaryTableTableFilterComposer(ComposerState($state.db,
                $state.db.apiaryTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter raportTableRefs(
      ComposableFilter Function($$RaportTableTableFilterComposer f) f) {
    final $$RaportTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.hiveId,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableFilterComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$HiveTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $HiveTableTable> {
  $$HiveTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get order => $state.composableBuilder(
      column: $state.table.order,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$QueenTableTableOrderingComposer get queenId {
    final $$QueenTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.queenId,
        referencedTable: $state.db.queenTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$QueenTableTableOrderingComposer(ComposerState($state.db,
                $state.db.queenTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$ApiaryTableTableOrderingComposer get apiaryId {
    final $$ApiaryTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.apiaryId,
        referencedTable: $state.db.apiaryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ApiaryTableTableOrderingComposer(ComposerState($state.db,
                $state.db.apiaryTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$HiveTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $HiveTableTable,
    Hive,
    $$HiveTableTableFilterComposer,
    $$HiveTableTableOrderingComposer,
    $$HiveTableTableCreateCompanionBuilder,
    $$HiveTableTableUpdateCompanionBuilder,
    (Hive, $$HiveTableTableReferences),
    Hive,
    PrefetchHooks Function(
        {bool queenId, bool apiaryId, bool raportTableRefs})> {
  $$HiveTableTableTableManager(_$DriftAppDatabase db, $HiveTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HiveTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HiveTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> queenId = const Value.absent(),
            Value<String> apiaryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HiveTableCompanion(
            id: id,
            name: name,
            order: order,
            type: type,
            queenId: queenId,
            apiaryId: apiaryId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required int order,
            required String type,
            Value<String?> queenId = const Value.absent(),
            required String apiaryId,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              HiveTableCompanion.insert(
            id: id,
            name: name,
            order: order,
            type: type,
            queenId: queenId,
            apiaryId: apiaryId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HiveTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {queenId = false, apiaryId = false, raportTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (raportTableRefs) db.raportTable],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (queenId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.queenId,
                    referencedTable:
                        $$HiveTableTableReferences._queenIdTable(db),
                    referencedColumn:
                        $$HiveTableTableReferences._queenIdTable(db).id,
                  ) as T;
                }
                if (apiaryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.apiaryId,
                    referencedTable:
                        $$HiveTableTableReferences._apiaryIdTable(db),
                    referencedColumn:
                        $$HiveTableTableReferences._apiaryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (raportTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$HiveTableTableReferences
                            ._raportTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HiveTableTableReferences(db, table, p0)
                                .raportTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.hiveId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HiveTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $HiveTableTable,
    Hive,
    $$HiveTableTableFilterComposer,
    $$HiveTableTableOrderingComposer,
    $$HiveTableTableCreateCompanionBuilder,
    $$HiveTableTableUpdateCompanionBuilder,
    (Hive, $$HiveTableTableReferences),
    Hive,
    PrefetchHooks Function(
        {bool queenId, bool apiaryId, bool raportTableRefs})>;
typedef $$RaportTableTableCreateCompanionBuilder = RaportTableCompanion
    Function({
  required String id,
  Value<String?> hiveId,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$RaportTableTableUpdateCompanionBuilder = RaportTableCompanion
    Function({
  Value<String> id,
  Value<String?> hiveId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$RaportTableTableReferences
    extends BaseReferences<_$DriftAppDatabase, $RaportTableTable, Raport> {
  $$RaportTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HiveTableTable _hiveIdTable(_$DriftAppDatabase db) =>
      db.hiveTable.createAlias(
          $_aliasNameGenerator(db.raportTable.hiveId, db.hiveTable.id));

  $$HiveTableTableProcessedTableManager? get hiveId {
    if ($_item.hiveId == null) return null;
    final manager = $$HiveTableTableTableManager($_db, $_db.hiveTable)
        .filter((f) => f.id($_item.hiveId!));
    final item = $_typedResult.readTableOrNull(_hiveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BooleanEntryTableTable, List<BooleanEntry>>
      _booleanEntryTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.booleanEntryTable,
              aliasName: $_aliasNameGenerator(
                  db.raportTable.id, db.booleanEntryTable.raportId));

  $$BooleanEntryTableTableProcessedTableManager get booleanEntryTableRefs {
    final manager =
        $$BooleanEntryTableTableTableManager($_db, $_db.booleanEntryTable)
            .filter((f) => f.raportId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_booleanEntryTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TextEntryTableTable, List<TextEntry>>
      _textEntryTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.textEntryTable,
              aliasName: $_aliasNameGenerator(
                  db.raportTable.id, db.textEntryTable.raportId));

  $$TextEntryTableTableProcessedTableManager get textEntryTableRefs {
    final manager = $$TextEntryTableTableTableManager($_db, $_db.textEntryTable)
        .filter((f) => f.raportId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_textEntryTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$NumericEntryTableTable, List<NumericEntry>>
      _numericEntryTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.numericEntryTable,
              aliasName: $_aliasNameGenerator(
                  db.raportTable.id, db.numericEntryTable.raportId));

  $$NumericEntryTableTableProcessedTableManager get numericEntryTableRefs {
    final manager =
        $$NumericEntryTableTableTableManager($_db, $_db.numericEntryTable)
            .filter((f) => f.raportId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_numericEntryTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RaportTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $RaportTableTable> {
  $$RaportTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$HiveTableTableFilterComposer get hiveId {
    final $$HiveTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hiveId,
        referencedTable: $state.db.hiveTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$HiveTableTableFilterComposer(ComposerState(
                $state.db, $state.db.hiveTable, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter booleanEntryTableRefs(
      ComposableFilter Function($$BooleanEntryTableTableFilterComposer f) f) {
    final $$BooleanEntryTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.booleanEntryTable,
            getReferencedColumn: (t) => t.raportId,
            builder: (joinBuilder, parentComposers) =>
                $$BooleanEntryTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.booleanEntryTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter textEntryTableRefs(
      ComposableFilter Function($$TextEntryTableTableFilterComposer f) f) {
    final $$TextEntryTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.textEntryTable,
        getReferencedColumn: (t) => t.raportId,
        builder: (joinBuilder, parentComposers) =>
            $$TextEntryTableTableFilterComposer(ComposerState($state.db,
                $state.db.textEntryTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter numericEntryTableRefs(
      ComposableFilter Function($$NumericEntryTableTableFilterComposer f) f) {
    final $$NumericEntryTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.numericEntryTable,
            getReferencedColumn: (t) => t.raportId,
            builder: (joinBuilder, parentComposers) =>
                $$NumericEntryTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.numericEntryTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$RaportTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $RaportTableTable> {
  $$RaportTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$HiveTableTableOrderingComposer get hiveId {
    final $$HiveTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hiveId,
        referencedTable: $state.db.hiveTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$HiveTableTableOrderingComposer(ComposerState(
                $state.db, $state.db.hiveTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$RaportTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $RaportTableTable,
    Raport,
    $$RaportTableTableFilterComposer,
    $$RaportTableTableOrderingComposer,
    $$RaportTableTableCreateCompanionBuilder,
    $$RaportTableTableUpdateCompanionBuilder,
    (Raport, $$RaportTableTableReferences),
    Raport,
    PrefetchHooks Function(
        {bool hiveId,
        bool booleanEntryTableRefs,
        bool textEntryTableRefs,
        bool numericEntryTableRefs})> {
  $$RaportTableTableTableManager(_$DriftAppDatabase db, $RaportTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RaportTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RaportTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> hiveId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RaportTableCompanion(
            id: id,
            hiveId: hiveId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> hiveId = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RaportTableCompanion.insert(
            id: id,
            hiveId: hiveId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RaportTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {hiveId = false,
              booleanEntryTableRefs = false,
              textEntryTableRefs = false,
              numericEntryTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (booleanEntryTableRefs) db.booleanEntryTable,
                if (textEntryTableRefs) db.textEntryTable,
                if (numericEntryTableRefs) db.numericEntryTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (hiveId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.hiveId,
                    referencedTable:
                        $$RaportTableTableReferences._hiveIdTable(db),
                    referencedColumn:
                        $$RaportTableTableReferences._hiveIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (booleanEntryTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RaportTableTableReferences
                            ._booleanEntryTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RaportTableTableReferences(db, table, p0)
                                .booleanEntryTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.raportId == item.id),
                        typedResults: items),
                  if (textEntryTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RaportTableTableReferences
                            ._textEntryTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RaportTableTableReferences(db, table, p0)
                                .textEntryTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.raportId == item.id),
                        typedResults: items),
                  if (numericEntryTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$RaportTableTableReferences
                            ._numericEntryTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RaportTableTableReferences(db, table, p0)
                                .numericEntryTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.raportId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RaportTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $RaportTableTable,
    Raport,
    $$RaportTableTableFilterComposer,
    $$RaportTableTableOrderingComposer,
    $$RaportTableTableCreateCompanionBuilder,
    $$RaportTableTableUpdateCompanionBuilder,
    (Raport, $$RaportTableTableReferences),
    Raport,
    PrefetchHooks Function(
        {bool hiveId,
        bool booleanEntryTableRefs,
        bool textEntryTableRefs,
        bool numericEntryTableRefs})>;
typedef $$EntryMetadataTableTableCreateCompanionBuilder
    = EntryMetadataTableCompanion Function({
  required String id,
  required String label,
  required String hint,
  required EntryType valueType,
  required RaportType raportType,
  Value<int> rowid,
});
typedef $$EntryMetadataTableTableUpdateCompanionBuilder
    = EntryMetadataTableCompanion Function({
  Value<String> id,
  Value<String> label,
  Value<String> hint,
  Value<EntryType> valueType,
  Value<RaportType> raportType,
  Value<int> rowid,
});

final class $$EntryMetadataTableTableReferences extends BaseReferences<
    _$DriftAppDatabase, $EntryMetadataTableTable, EntryMetadata> {
  $$EntryMetadataTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BooleanEntryTableTable, List<BooleanEntry>>
      _booleanEntryTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.booleanEntryTable,
              aliasName: $_aliasNameGenerator(db.entryMetadataTable.id,
                  db.booleanEntryTable.entryMetadataId));

  $$BooleanEntryTableTableProcessedTableManager get booleanEntryTableRefs {
    final manager =
        $$BooleanEntryTableTableTableManager($_db, $_db.booleanEntryTable)
            .filter((f) => f.entryMetadataId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_booleanEntryTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TextEntryTableTable, List<TextEntry>>
      _textEntryTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.textEntryTable,
              aliasName: $_aliasNameGenerator(
                  db.entryMetadataTable.id, db.textEntryTable.entryMetadataId));

  $$TextEntryTableTableProcessedTableManager get textEntryTableRefs {
    final manager = $$TextEntryTableTableTableManager($_db, $_db.textEntryTable)
        .filter((f) => f.entryMetadataId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_textEntryTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$NumericEntryTableTable, List<NumericEntry>>
      _numericEntryTableRefsTable(_$DriftAppDatabase db) =>
          MultiTypedResultKey.fromTable(db.numericEntryTable,
              aliasName: $_aliasNameGenerator(db.entryMetadataTable.id,
                  db.numericEntryTable.entryMetadataId));

  $$NumericEntryTableTableProcessedTableManager get numericEntryTableRefs {
    final manager =
        $$NumericEntryTableTableTableManager($_db, $_db.numericEntryTable)
            .filter((f) => f.entryMetadataId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_numericEntryTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EntryMetadataTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $EntryMetadataTableTable> {
  $$EntryMetadataTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get label => $state.composableBuilder(
      column: $state.table.label,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get hint => $state.composableBuilder(
      column: $state.table.hint,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<EntryType, EntryType, int> get valueType =>
      $state.composableBuilder(
          column: $state.table.valueType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<RaportType, RaportType, int> get raportType =>
      $state.composableBuilder(
          column: $state.table.raportType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ComposableFilter booleanEntryTableRefs(
      ComposableFilter Function($$BooleanEntryTableTableFilterComposer f) f) {
    final $$BooleanEntryTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.booleanEntryTable,
            getReferencedColumn: (t) => t.entryMetadataId,
            builder: (joinBuilder, parentComposers) =>
                $$BooleanEntryTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.booleanEntryTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }

  ComposableFilter textEntryTableRefs(
      ComposableFilter Function($$TextEntryTableTableFilterComposer f) f) {
    final $$TextEntryTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.textEntryTable,
        getReferencedColumn: (t) => t.entryMetadataId,
        builder: (joinBuilder, parentComposers) =>
            $$TextEntryTableTableFilterComposer(ComposerState($state.db,
                $state.db.textEntryTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter numericEntryTableRefs(
      ComposableFilter Function($$NumericEntryTableTableFilterComposer f) f) {
    final $$NumericEntryTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.numericEntryTable,
            getReferencedColumn: (t) => t.entryMetadataId,
            builder: (joinBuilder, parentComposers) =>
                $$NumericEntryTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.numericEntryTable,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$EntryMetadataTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $EntryMetadataTableTable> {
  $$EntryMetadataTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get label => $state.composableBuilder(
      column: $state.table.label,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get hint => $state.composableBuilder(
      column: $state.table.hint,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get valueType => $state.composableBuilder(
      column: $state.table.valueType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get raportType => $state.composableBuilder(
      column: $state.table.raportType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$EntryMetadataTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $EntryMetadataTableTable,
    EntryMetadata,
    $$EntryMetadataTableTableFilterComposer,
    $$EntryMetadataTableTableOrderingComposer,
    $$EntryMetadataTableTableCreateCompanionBuilder,
    $$EntryMetadataTableTableUpdateCompanionBuilder,
    (EntryMetadata, $$EntryMetadataTableTableReferences),
    EntryMetadata,
    PrefetchHooks Function(
        {bool booleanEntryTableRefs,
        bool textEntryTableRefs,
        bool numericEntryTableRefs})> {
  $$EntryMetadataTableTableTableManager(
      _$DriftAppDatabase db, $EntryMetadataTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$EntryMetadataTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$EntryMetadataTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> hint = const Value.absent(),
            Value<EntryType> valueType = const Value.absent(),
            Value<RaportType> raportType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntryMetadataTableCompanion(
            id: id,
            label: label,
            hint: hint,
            valueType: valueType,
            raportType: raportType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String label,
            required String hint,
            required EntryType valueType,
            required RaportType raportType,
            Value<int> rowid = const Value.absent(),
          }) =>
              EntryMetadataTableCompanion.insert(
            id: id,
            label: label,
            hint: hint,
            valueType: valueType,
            raportType: raportType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EntryMetadataTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {booleanEntryTableRefs = false,
              textEntryTableRefs = false,
              numericEntryTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (booleanEntryTableRefs) db.booleanEntryTable,
                if (textEntryTableRefs) db.textEntryTable,
                if (numericEntryTableRefs) db.numericEntryTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (booleanEntryTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$EntryMetadataTableTableReferences
                            ._booleanEntryTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EntryMetadataTableTableReferences(db, table, p0)
                                .booleanEntryTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.entryMetadataId == item.id),
                        typedResults: items),
                  if (textEntryTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$EntryMetadataTableTableReferences
                            ._textEntryTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EntryMetadataTableTableReferences(db, table, p0)
                                .textEntryTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.entryMetadataId == item.id),
                        typedResults: items),
                  if (numericEntryTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$EntryMetadataTableTableReferences
                            ._numericEntryTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EntryMetadataTableTableReferences(db, table, p0)
                                .numericEntryTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.entryMetadataId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EntryMetadataTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $EntryMetadataTableTable,
    EntryMetadata,
    $$EntryMetadataTableTableFilterComposer,
    $$EntryMetadataTableTableOrderingComposer,
    $$EntryMetadataTableTableCreateCompanionBuilder,
    $$EntryMetadataTableTableUpdateCompanionBuilder,
    (EntryMetadata, $$EntryMetadataTableTableReferences),
    EntryMetadata,
    PrefetchHooks Function(
        {bool booleanEntryTableRefs,
        bool textEntryTableRefs,
        bool numericEntryTableRefs})>;
typedef $$BooleanEntryTableTableCreateCompanionBuilder
    = BooleanEntryTableCompanion Function({
  required String id,
  required String raportId,
  required String entryMetadataId,
  required bool value,
  Value<int> rowid,
});
typedef $$BooleanEntryTableTableUpdateCompanionBuilder
    = BooleanEntryTableCompanion Function({
  Value<String> id,
  Value<String> raportId,
  Value<String> entryMetadataId,
  Value<bool> value,
  Value<int> rowid,
});

final class $$BooleanEntryTableTableReferences extends BaseReferences<
    _$DriftAppDatabase, $BooleanEntryTableTable, BooleanEntry> {
  $$BooleanEntryTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RaportTableTable _raportIdTable(_$DriftAppDatabase db) =>
      db.raportTable.createAlias($_aliasNameGenerator(
          db.booleanEntryTable.raportId, db.raportTable.id));

  $$RaportTableTableProcessedTableManager? get raportId {
    if ($_item.raportId == null) return null;
    final manager = $$RaportTableTableTableManager($_db, $_db.raportTable)
        .filter((f) => f.id($_item.raportId!));
    final item = $_typedResult.readTableOrNull(_raportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntryMetadataTableTable _entryMetadataIdTable(
          _$DriftAppDatabase db) =>
      db.entryMetadataTable.createAlias($_aliasNameGenerator(
          db.booleanEntryTable.entryMetadataId, db.entryMetadataTable.id));

  $$EntryMetadataTableTableProcessedTableManager? get entryMetadataId {
    if ($_item.entryMetadataId == null) return null;
    final manager =
        $$EntryMetadataTableTableTableManager($_db, $_db.entryMetadataTable)
            .filter((f) => f.id($_item.entryMetadataId!));
    final item = $_typedResult.readTableOrNull(_entryMetadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BooleanEntryTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $BooleanEntryTableTable> {
  $$BooleanEntryTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RaportTableTableFilterComposer get raportId {
    final $$RaportTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.raportId,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableFilterComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$EntryMetadataTableTableFilterComposer get entryMetadataId {
    final $$EntryMetadataTableTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.entryMetadataId,
            referencedTable: $state.db.entryMetadataTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$EntryMetadataTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.entryMetadataTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$BooleanEntryTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $BooleanEntryTableTable> {
  $$BooleanEntryTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RaportTableTableOrderingComposer get raportId {
    final $$RaportTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.raportId,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableOrderingComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$EntryMetadataTableTableOrderingComposer get entryMetadataId {
    final $$EntryMetadataTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.entryMetadataId,
            referencedTable: $state.db.entryMetadataTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$EntryMetadataTableTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.entryMetadataTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$BooleanEntryTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $BooleanEntryTableTable,
    BooleanEntry,
    $$BooleanEntryTableTableFilterComposer,
    $$BooleanEntryTableTableOrderingComposer,
    $$BooleanEntryTableTableCreateCompanionBuilder,
    $$BooleanEntryTableTableUpdateCompanionBuilder,
    (BooleanEntry, $$BooleanEntryTableTableReferences),
    BooleanEntry,
    PrefetchHooks Function({bool raportId, bool entryMetadataId})> {
  $$BooleanEntryTableTableTableManager(
      _$DriftAppDatabase db, $BooleanEntryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BooleanEntryTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$BooleanEntryTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> raportId = const Value.absent(),
            Value<String> entryMetadataId = const Value.absent(),
            Value<bool> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BooleanEntryTableCompanion(
            id: id,
            raportId: raportId,
            entryMetadataId: entryMetadataId,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String raportId,
            required String entryMetadataId,
            required bool value,
            Value<int> rowid = const Value.absent(),
          }) =>
              BooleanEntryTableCompanion.insert(
            id: id,
            raportId: raportId,
            entryMetadataId: entryMetadataId,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BooleanEntryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({raportId = false, entryMetadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (raportId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.raportId,
                    referencedTable:
                        $$BooleanEntryTableTableReferences._raportIdTable(db),
                    referencedColumn: $$BooleanEntryTableTableReferences
                        ._raportIdTable(db)
                        .id,
                  ) as T;
                }
                if (entryMetadataId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryMetadataId,
                    referencedTable: $$BooleanEntryTableTableReferences
                        ._entryMetadataIdTable(db),
                    referencedColumn: $$BooleanEntryTableTableReferences
                        ._entryMetadataIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BooleanEntryTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $BooleanEntryTableTable,
    BooleanEntry,
    $$BooleanEntryTableTableFilterComposer,
    $$BooleanEntryTableTableOrderingComposer,
    $$BooleanEntryTableTableCreateCompanionBuilder,
    $$BooleanEntryTableTableUpdateCompanionBuilder,
    (BooleanEntry, $$BooleanEntryTableTableReferences),
    BooleanEntry,
    PrefetchHooks Function({bool raportId, bool entryMetadataId})>;
typedef $$TextEntryTableTableCreateCompanionBuilder = TextEntryTableCompanion
    Function({
  required String id,
  required String raportId,
  required String entryMetadataId,
  required String value,
  Value<int> rowid,
});
typedef $$TextEntryTableTableUpdateCompanionBuilder = TextEntryTableCompanion
    Function({
  Value<String> id,
  Value<String> raportId,
  Value<String> entryMetadataId,
  Value<String> value,
  Value<int> rowid,
});

final class $$TextEntryTableTableReferences extends BaseReferences<
    _$DriftAppDatabase, $TextEntryTableTable, TextEntry> {
  $$TextEntryTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RaportTableTable _raportIdTable(_$DriftAppDatabase db) =>
      db.raportTable.createAlias(
          $_aliasNameGenerator(db.textEntryTable.raportId, db.raportTable.id));

  $$RaportTableTableProcessedTableManager? get raportId {
    if ($_item.raportId == null) return null;
    final manager = $$RaportTableTableTableManager($_db, $_db.raportTable)
        .filter((f) => f.id($_item.raportId!));
    final item = $_typedResult.readTableOrNull(_raportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntryMetadataTableTable _entryMetadataIdTable(
          _$DriftAppDatabase db) =>
      db.entryMetadataTable.createAlias($_aliasNameGenerator(
          db.textEntryTable.entryMetadataId, db.entryMetadataTable.id));

  $$EntryMetadataTableTableProcessedTableManager? get entryMetadataId {
    if ($_item.entryMetadataId == null) return null;
    final manager =
        $$EntryMetadataTableTableTableManager($_db, $_db.entryMetadataTable)
            .filter((f) => f.id($_item.entryMetadataId!));
    final item = $_typedResult.readTableOrNull(_entryMetadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TextEntryTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $TextEntryTableTable> {
  $$TextEntryTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RaportTableTableFilterComposer get raportId {
    final $$RaportTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.raportId,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableFilterComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$EntryMetadataTableTableFilterComposer get entryMetadataId {
    final $$EntryMetadataTableTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.entryMetadataId,
            referencedTable: $state.db.entryMetadataTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$EntryMetadataTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.entryMetadataTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$TextEntryTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $TextEntryTableTable> {
  $$TextEntryTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RaportTableTableOrderingComposer get raportId {
    final $$RaportTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.raportId,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableOrderingComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$EntryMetadataTableTableOrderingComposer get entryMetadataId {
    final $$EntryMetadataTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.entryMetadataId,
            referencedTable: $state.db.entryMetadataTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$EntryMetadataTableTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.entryMetadataTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$TextEntryTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $TextEntryTableTable,
    TextEntry,
    $$TextEntryTableTableFilterComposer,
    $$TextEntryTableTableOrderingComposer,
    $$TextEntryTableTableCreateCompanionBuilder,
    $$TextEntryTableTableUpdateCompanionBuilder,
    (TextEntry, $$TextEntryTableTableReferences),
    TextEntry,
    PrefetchHooks Function({bool raportId, bool entryMetadataId})> {
  $$TextEntryTableTableTableManager(
      _$DriftAppDatabase db, $TextEntryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TextEntryTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TextEntryTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> raportId = const Value.absent(),
            Value<String> entryMetadataId = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TextEntryTableCompanion(
            id: id,
            raportId: raportId,
            entryMetadataId: entryMetadataId,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String raportId,
            required String entryMetadataId,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              TextEntryTableCompanion.insert(
            id: id,
            raportId: raportId,
            entryMetadataId: entryMetadataId,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TextEntryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({raportId = false, entryMetadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (raportId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.raportId,
                    referencedTable:
                        $$TextEntryTableTableReferences._raportIdTable(db),
                    referencedColumn:
                        $$TextEntryTableTableReferences._raportIdTable(db).id,
                  ) as T;
                }
                if (entryMetadataId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryMetadataId,
                    referencedTable: $$TextEntryTableTableReferences
                        ._entryMetadataIdTable(db),
                    referencedColumn: $$TextEntryTableTableReferences
                        ._entryMetadataIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TextEntryTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $TextEntryTableTable,
    TextEntry,
    $$TextEntryTableTableFilterComposer,
    $$TextEntryTableTableOrderingComposer,
    $$TextEntryTableTableCreateCompanionBuilder,
    $$TextEntryTableTableUpdateCompanionBuilder,
    (TextEntry, $$TextEntryTableTableReferences),
    TextEntry,
    PrefetchHooks Function({bool raportId, bool entryMetadataId})>;
typedef $$NumericEntryTableTableCreateCompanionBuilder
    = NumericEntryTableCompanion Function({
  required String id,
  required String raportId,
  required String entryMetadataId,
  required double value,
  Value<int> rowid,
});
typedef $$NumericEntryTableTableUpdateCompanionBuilder
    = NumericEntryTableCompanion Function({
  Value<String> id,
  Value<String> raportId,
  Value<String> entryMetadataId,
  Value<double> value,
  Value<int> rowid,
});

final class $$NumericEntryTableTableReferences extends BaseReferences<
    _$DriftAppDatabase, $NumericEntryTableTable, NumericEntry> {
  $$NumericEntryTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RaportTableTable _raportIdTable(_$DriftAppDatabase db) =>
      db.raportTable.createAlias($_aliasNameGenerator(
          db.numericEntryTable.raportId, db.raportTable.id));

  $$RaportTableTableProcessedTableManager? get raportId {
    if ($_item.raportId == null) return null;
    final manager = $$RaportTableTableTableManager($_db, $_db.raportTable)
        .filter((f) => f.id($_item.raportId!));
    final item = $_typedResult.readTableOrNull(_raportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EntryMetadataTableTable _entryMetadataIdTable(
          _$DriftAppDatabase db) =>
      db.entryMetadataTable.createAlias($_aliasNameGenerator(
          db.numericEntryTable.entryMetadataId, db.entryMetadataTable.id));

  $$EntryMetadataTableTableProcessedTableManager? get entryMetadataId {
    if ($_item.entryMetadataId == null) return null;
    final manager =
        $$EntryMetadataTableTableTableManager($_db, $_db.entryMetadataTable)
            .filter((f) => f.id($_item.entryMetadataId!));
    final item = $_typedResult.readTableOrNull(_entryMetadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$NumericEntryTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $NumericEntryTableTable> {
  $$NumericEntryTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RaportTableTableFilterComposer get raportId {
    final $$RaportTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.raportId,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableFilterComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$EntryMetadataTableTableFilterComposer get entryMetadataId {
    final $$EntryMetadataTableTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.entryMetadataId,
            referencedTable: $state.db.entryMetadataTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$EntryMetadataTableTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.entryMetadataTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$NumericEntryTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $NumericEntryTableTable> {
  $$NumericEntryTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RaportTableTableOrderingComposer get raportId {
    final $$RaportTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.raportId,
        referencedTable: $state.db.raportTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RaportTableTableOrderingComposer(ComposerState($state.db,
                $state.db.raportTable, joinBuilder, parentComposers)));
    return composer;
  }

  $$EntryMetadataTableTableOrderingComposer get entryMetadataId {
    final $$EntryMetadataTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.entryMetadataId,
            referencedTable: $state.db.entryMetadataTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$EntryMetadataTableTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.entryMetadataTable,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$NumericEntryTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $NumericEntryTableTable,
    NumericEntry,
    $$NumericEntryTableTableFilterComposer,
    $$NumericEntryTableTableOrderingComposer,
    $$NumericEntryTableTableCreateCompanionBuilder,
    $$NumericEntryTableTableUpdateCompanionBuilder,
    (NumericEntry, $$NumericEntryTableTableReferences),
    NumericEntry,
    PrefetchHooks Function({bool raportId, bool entryMetadataId})> {
  $$NumericEntryTableTableTableManager(
      _$DriftAppDatabase db, $NumericEntryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NumericEntryTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$NumericEntryTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> raportId = const Value.absent(),
            Value<String> entryMetadataId = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NumericEntryTableCompanion(
            id: id,
            raportId: raportId,
            entryMetadataId: entryMetadataId,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String raportId,
            required String entryMetadataId,
            required double value,
            Value<int> rowid = const Value.absent(),
          }) =>
              NumericEntryTableCompanion.insert(
            id: id,
            raportId: raportId,
            entryMetadataId: entryMetadataId,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$NumericEntryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({raportId = false, entryMetadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (raportId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.raportId,
                    referencedTable:
                        $$NumericEntryTableTableReferences._raportIdTable(db),
                    referencedColumn: $$NumericEntryTableTableReferences
                        ._raportIdTable(db)
                        .id,
                  ) as T;
                }
                if (entryMetadataId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryMetadataId,
                    referencedTable: $$NumericEntryTableTableReferences
                        ._entryMetadataIdTable(db),
                    referencedColumn: $$NumericEntryTableTableReferences
                        ._entryMetadataIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$NumericEntryTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $NumericEntryTableTable,
    NumericEntry,
    $$NumericEntryTableTableFilterComposer,
    $$NumericEntryTableTableOrderingComposer,
    $$NumericEntryTableTableCreateCompanionBuilder,
    $$NumericEntryTableTableUpdateCompanionBuilder,
    (NumericEntry, $$NumericEntryTableTableReferences),
    NumericEntry,
    PrefetchHooks Function({bool raportId, bool entryMetadataId})>;
typedef $$TodoTableTableCreateCompanionBuilder = TodoTableCompanion Function({
  required String id,
  required String location,
  required String description,
  required CategoryType categoryType,
  required DateTime dueTo,
  required bool isCompleted,
  Value<int> rowid,
});
typedef $$TodoTableTableUpdateCompanionBuilder = TodoTableCompanion Function({
  Value<String> id,
  Value<String> location,
  Value<String> description,
  Value<CategoryType> categoryType,
  Value<DateTime> dueTo,
  Value<bool> isCompleted,
  Value<int> rowid,
});

class $$TodoTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $TodoTableTable> {
  $$TodoTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<CategoryType, CategoryType, int>
      get categoryType => $state.composableBuilder(
          column: $state.table.categoryType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dueTo => $state.composableBuilder(
      column: $state.table.dueTo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TodoTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $TodoTableTable> {
  $$TodoTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get categoryType => $state.composableBuilder(
      column: $state.table.categoryType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dueTo => $state.composableBuilder(
      column: $state.table.dueTo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$TodoTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $TodoTableTable,
    Todo,
    $$TodoTableTableFilterComposer,
    $$TodoTableTableOrderingComposer,
    $$TodoTableTableCreateCompanionBuilder,
    $$TodoTableTableUpdateCompanionBuilder,
    (Todo, BaseReferences<_$DriftAppDatabase, $TodoTableTable, Todo>),
    Todo,
    PrefetchHooks Function()> {
  $$TodoTableTableTableManager(_$DriftAppDatabase db, $TodoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TodoTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TodoTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<CategoryType> categoryType = const Value.absent(),
            Value<DateTime> dueTo = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TodoTableCompanion(
            id: id,
            location: location,
            description: description,
            categoryType: categoryType,
            dueTo: dueTo,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String location,
            required String description,
            required CategoryType categoryType,
            required DateTime dueTo,
            required bool isCompleted,
            Value<int> rowid = const Value.absent(),
          }) =>
              TodoTableCompanion.insert(
            id: id,
            location: location,
            description: description,
            categoryType: categoryType,
            dueTo: dueTo,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TodoTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $TodoTableTable,
    Todo,
    $$TodoTableTableFilterComposer,
    $$TodoTableTableOrderingComposer,
    $$TodoTableTableCreateCompanionBuilder,
    $$TodoTableTableUpdateCompanionBuilder,
    (Todo, BaseReferences<_$DriftAppDatabase, $TodoTableTable, Todo>),
    Todo,
    PrefetchHooks Function()>;
typedef $$HistoryLogTableTableCreateCompanionBuilder = HistoryLogTableCompanion
    Function({
  required String id,
  required String referenceId,
  required TableType tableType,
  required ActionType actionType,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$HistoryLogTableTableUpdateCompanionBuilder = HistoryLogTableCompanion
    Function({
  Value<String> id,
  Value<String> referenceId,
  Value<TableType> tableType,
  Value<ActionType> actionType,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$HistoryLogTableTableFilterComposer
    extends FilterComposer<_$DriftAppDatabase, $HistoryLogTableTable> {
  $$HistoryLogTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get referenceId => $state.composableBuilder(
      column: $state.table.referenceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<TableType, TableType, int> get tableType =>
      $state.composableBuilder(
          column: $state.table.tableType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<ActionType, ActionType, int> get actionType =>
      $state.composableBuilder(
          column: $state.table.actionType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HistoryLogTableTableOrderingComposer
    extends OrderingComposer<_$DriftAppDatabase, $HistoryLogTableTable> {
  $$HistoryLogTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get referenceId => $state.composableBuilder(
      column: $state.table.referenceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get tableType => $state.composableBuilder(
      column: $state.table.tableType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get actionType => $state.composableBuilder(
      column: $state.table.actionType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$HistoryLogTableTableTableManager extends RootTableManager<
    _$DriftAppDatabase,
    $HistoryLogTableTable,
    HistoryLog,
    $$HistoryLogTableTableFilterComposer,
    $$HistoryLogTableTableOrderingComposer,
    $$HistoryLogTableTableCreateCompanionBuilder,
    $$HistoryLogTableTableUpdateCompanionBuilder,
    (
      HistoryLog,
      BaseReferences<_$DriftAppDatabase, $HistoryLogTableTable, HistoryLog>
    ),
    HistoryLog,
    PrefetchHooks Function()> {
  $$HistoryLogTableTableTableManager(
      _$DriftAppDatabase db, $HistoryLogTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HistoryLogTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HistoryLogTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> referenceId = const Value.absent(),
            Value<TableType> tableType = const Value.absent(),
            Value<ActionType> actionType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HistoryLogTableCompanion(
            id: id,
            referenceId: referenceId,
            tableType: tableType,
            actionType: actionType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String referenceId,
            required TableType tableType,
            required ActionType actionType,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              HistoryLogTableCompanion.insert(
            id: id,
            referenceId: referenceId,
            tableType: tableType,
            actionType: actionType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistoryLogTableTableProcessedTableManager = ProcessedTableManager<
    _$DriftAppDatabase,
    $HistoryLogTableTable,
    HistoryLog,
    $$HistoryLogTableTableFilterComposer,
    $$HistoryLogTableTableOrderingComposer,
    $$HistoryLogTableTableCreateCompanionBuilder,
    $$HistoryLogTableTableUpdateCompanionBuilder,
    (
      HistoryLog,
      BaseReferences<_$DriftAppDatabase, $HistoryLogTableTable, HistoryLog>
    ),
    HistoryLog,
    PrefetchHooks Function()>;

class $DriftAppDatabaseManager {
  final _$DriftAppDatabase _db;
  $DriftAppDatabaseManager(this._db);
  $$ApiaryTableTableTableManager get apiaryTable =>
      $$ApiaryTableTableTableManager(_db, _db.apiaryTable);
  $$QueenTableTableTableManager get queenTable =>
      $$QueenTableTableTableManager(_db, _db.queenTable);
  $$HiveTableTableTableManager get hiveTable =>
      $$HiveTableTableTableManager(_db, _db.hiveTable);
  $$RaportTableTableTableManager get raportTable =>
      $$RaportTableTableTableManager(_db, _db.raportTable);
  $$EntryMetadataTableTableTableManager get entryMetadataTable =>
      $$EntryMetadataTableTableTableManager(_db, _db.entryMetadataTable);
  $$BooleanEntryTableTableTableManager get booleanEntryTable =>
      $$BooleanEntryTableTableTableManager(_db, _db.booleanEntryTable);
  $$TextEntryTableTableTableManager get textEntryTable =>
      $$TextEntryTableTableTableManager(_db, _db.textEntryTable);
  $$NumericEntryTableTableTableManager get numericEntryTable =>
      $$NumericEntryTableTableTableManager(_db, _db.numericEntryTable);
  $$TodoTableTableTableManager get todoTable =>
      $$TodoTableTableTableManager(_db, _db.todoTable);
  $$HistoryLogTableTableTableManager get historyLogTable =>
      $$HistoryLogTableTableTableManager(_db, _db.historyLogTable);
}
