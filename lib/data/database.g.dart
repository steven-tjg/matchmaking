// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final DateTime createdAt;
  const Player({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Player copyWith({int? id, String? name, DateTime? createdAt}) => Player(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MeetsTable extends Meets with TableInfo<$MeetsTable, Meet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courtCountMeta = const VerificationMeta(
    'courtCount',
  );
  @override
  late final GeneratedColumn<int> courtCount = GeneratedColumn<int>(
    'court_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    scheduledAt,
    durationMinutes,
    location,
    courtCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('court_count')) {
      context.handle(
        _courtCountMeta,
        courtCount.isAcceptableOrUnknown(data['court_count']!, _courtCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      courtCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}court_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MeetsTable createAlias(String alias) {
    return $MeetsTable(attachedDatabase, alias);
  }
}

class Meet extends DataClass implements Insertable<Meet> {
  final int id;
  final String name;
  final DateTime scheduledAt;
  final int durationMinutes;
  final String location;
  final int courtCount;
  final DateTime createdAt;
  const Meet({
    required this.id,
    required this.name,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.location,
    required this.courtCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['location'] = Variable<String>(location);
    map['court_count'] = Variable<int>(courtCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MeetsCompanion toCompanion(bool nullToAbsent) {
    return MeetsCompanion(
      id: Value(id),
      name: Value(name),
      scheduledAt: Value(scheduledAt),
      durationMinutes: Value(durationMinutes),
      location: Value(location),
      courtCount: Value(courtCount),
      createdAt: Value(createdAt),
    );
  }

  factory Meet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      location: serializer.fromJson<String>(json['location']),
      courtCount: serializer.fromJson<int>(json['courtCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'location': serializer.toJson<String>(location),
      'courtCount': serializer.toJson<int>(courtCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Meet copyWith({
    int? id,
    String? name,
    DateTime? scheduledAt,
    int? durationMinutes,
    String? location,
    int? courtCount,
    DateTime? createdAt,
  }) => Meet(
    id: id ?? this.id,
    name: name ?? this.name,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    location: location ?? this.location,
    courtCount: courtCount ?? this.courtCount,
    createdAt: createdAt ?? this.createdAt,
  );
  Meet copyWithCompanion(MeetsCompanion data) {
    return Meet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      location: data.location.present ? data.location.value : this.location,
      courtCount: data.courtCount.present
          ? data.courtCount.value
          : this.courtCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('location: $location, ')
          ..write('courtCount: $courtCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    scheduledAt,
    durationMinutes,
    location,
    courtCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meet &&
          other.id == this.id &&
          other.name == this.name &&
          other.scheduledAt == this.scheduledAt &&
          other.durationMinutes == this.durationMinutes &&
          other.location == this.location &&
          other.courtCount == this.courtCount &&
          other.createdAt == this.createdAt);
}

class MeetsCompanion extends UpdateCompanion<Meet> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> scheduledAt;
  final Value<int> durationMinutes;
  final Value<String> location;
  final Value<int> courtCount;
  final Value<DateTime> createdAt;
  const MeetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.location = const Value.absent(),
    this.courtCount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MeetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime scheduledAt,
    required int durationMinutes,
    required String location,
    this.courtCount = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       scheduledAt = Value(scheduledAt),
       durationMinutes = Value(durationMinutes),
       location = Value(location);
  static Insertable<Meet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? scheduledAt,
    Expression<int>? durationMinutes,
    Expression<String>? location,
    Expression<int>? courtCount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (location != null) 'location': location,
      if (courtCount != null) 'court_count': courtCount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MeetsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? scheduledAt,
    Value<int>? durationMinutes,
    Value<String>? location,
    Value<int>? courtCount,
    Value<DateTime>? createdAt,
  }) {
    return MeetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      location: location ?? this.location,
      courtCount: courtCount ?? this.courtCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (courtCount.present) {
      map['court_count'] = Variable<int>(courtCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('location: $location, ')
          ..write('courtCount: $courtCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MeetParticipantsTable extends MeetParticipants
    with TableInfo<$MeetParticipantsTable, MeetParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _meetIdMeta = const VerificationMeta('meetId');
  @override
  late final GeneratedColumn<int> meetId = GeneratedColumn<int>(
    'meet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _arrivalOrderMeta = const VerificationMeta(
    'arrivalOrder',
  );
  @override
  late final GeneratedColumn<int> arrivalOrder = GeneratedColumn<int>(
    'arrival_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkedInAtMeta = const VerificationMeta(
    'checkedInAt',
  );
  @override
  late final GeneratedColumn<DateTime> checkedInAt = GeneratedColumn<DateTime>(
    'checked_in_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gamesPlayedMeta = const VerificationMeta(
    'gamesPlayed',
  );
  @override
  late final GeneratedColumn<int> gamesPlayed = GeneratedColumn<int>(
    'games_played',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetId,
    playerId,
    arrivalOrder,
    checkedInAt,
    gamesPlayed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meet_participants';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetParticipant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meet_id')) {
      context.handle(
        _meetIdMeta,
        meetId.isAcceptableOrUnknown(data['meet_id']!, _meetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('arrival_order')) {
      context.handle(
        _arrivalOrderMeta,
        arrivalOrder.isAcceptableOrUnknown(
          data['arrival_order']!,
          _arrivalOrderMeta,
        ),
      );
    }
    if (data.containsKey('checked_in_at')) {
      context.handle(
        _checkedInAtMeta,
        checkedInAt.isAcceptableOrUnknown(
          data['checked_in_at']!,
          _checkedInAtMeta,
        ),
      );
    }
    if (data.containsKey('games_played')) {
      context.handle(
        _gamesPlayedMeta,
        gamesPlayed.isAcceptableOrUnknown(
          data['games_played']!,
          _gamesPlayedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {meetId, playerId},
  ];
  @override
  MeetParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetParticipant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      meetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meet_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      arrivalOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}arrival_order'],
      ),
      checkedInAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}checked_in_at'],
      ),
      gamesPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}games_played'],
      )!,
    );
  }

  @override
  $MeetParticipantsTable createAlias(String alias) {
    return $MeetParticipantsTable(attachedDatabase, alias);
  }
}

class MeetParticipant extends DataClass implements Insertable<MeetParticipant> {
  final int id;
  final int meetId;
  final int playerId;
  final int? arrivalOrder;
  final DateTime? checkedInAt;
  final int gamesPlayed;
  const MeetParticipant({
    required this.id,
    required this.meetId,
    required this.playerId,
    this.arrivalOrder,
    this.checkedInAt,
    required this.gamesPlayed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meet_id'] = Variable<int>(meetId);
    map['player_id'] = Variable<int>(playerId);
    if (!nullToAbsent || arrivalOrder != null) {
      map['arrival_order'] = Variable<int>(arrivalOrder);
    }
    if (!nullToAbsent || checkedInAt != null) {
      map['checked_in_at'] = Variable<DateTime>(checkedInAt);
    }
    map['games_played'] = Variable<int>(gamesPlayed);
    return map;
  }

  MeetParticipantsCompanion toCompanion(bool nullToAbsent) {
    return MeetParticipantsCompanion(
      id: Value(id),
      meetId: Value(meetId),
      playerId: Value(playerId),
      arrivalOrder: arrivalOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(arrivalOrder),
      checkedInAt: checkedInAt == null && nullToAbsent
          ? const Value.absent()
          : Value(checkedInAt),
      gamesPlayed: Value(gamesPlayed),
    );
  }

  factory MeetParticipant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetParticipant(
      id: serializer.fromJson<int>(json['id']),
      meetId: serializer.fromJson<int>(json['meetId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      arrivalOrder: serializer.fromJson<int?>(json['arrivalOrder']),
      checkedInAt: serializer.fromJson<DateTime?>(json['checkedInAt']),
      gamesPlayed: serializer.fromJson<int>(json['gamesPlayed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'meetId': serializer.toJson<int>(meetId),
      'playerId': serializer.toJson<int>(playerId),
      'arrivalOrder': serializer.toJson<int?>(arrivalOrder),
      'checkedInAt': serializer.toJson<DateTime?>(checkedInAt),
      'gamesPlayed': serializer.toJson<int>(gamesPlayed),
    };
  }

  MeetParticipant copyWith({
    int? id,
    int? meetId,
    int? playerId,
    Value<int?> arrivalOrder = const Value.absent(),
    Value<DateTime?> checkedInAt = const Value.absent(),
    int? gamesPlayed,
  }) => MeetParticipant(
    id: id ?? this.id,
    meetId: meetId ?? this.meetId,
    playerId: playerId ?? this.playerId,
    arrivalOrder: arrivalOrder.present ? arrivalOrder.value : this.arrivalOrder,
    checkedInAt: checkedInAt.present ? checkedInAt.value : this.checkedInAt,
    gamesPlayed: gamesPlayed ?? this.gamesPlayed,
  );
  MeetParticipant copyWithCompanion(MeetParticipantsCompanion data) {
    return MeetParticipant(
      id: data.id.present ? data.id.value : this.id,
      meetId: data.meetId.present ? data.meetId.value : this.meetId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      arrivalOrder: data.arrivalOrder.present
          ? data.arrivalOrder.value
          : this.arrivalOrder,
      checkedInAt: data.checkedInAt.present
          ? data.checkedInAt.value
          : this.checkedInAt,
      gamesPlayed: data.gamesPlayed.present
          ? data.gamesPlayed.value
          : this.gamesPlayed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetParticipant(')
          ..write('id: $id, ')
          ..write('meetId: $meetId, ')
          ..write('playerId: $playerId, ')
          ..write('arrivalOrder: $arrivalOrder, ')
          ..write('checkedInAt: $checkedInAt, ')
          ..write('gamesPlayed: $gamesPlayed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, meetId, playerId, arrivalOrder, checkedInAt, gamesPlayed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetParticipant &&
          other.id == this.id &&
          other.meetId == this.meetId &&
          other.playerId == this.playerId &&
          other.arrivalOrder == this.arrivalOrder &&
          other.checkedInAt == this.checkedInAt &&
          other.gamesPlayed == this.gamesPlayed);
}

class MeetParticipantsCompanion extends UpdateCompanion<MeetParticipant> {
  final Value<int> id;
  final Value<int> meetId;
  final Value<int> playerId;
  final Value<int?> arrivalOrder;
  final Value<DateTime?> checkedInAt;
  final Value<int> gamesPlayed;
  const MeetParticipantsCompanion({
    this.id = const Value.absent(),
    this.meetId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.arrivalOrder = const Value.absent(),
    this.checkedInAt = const Value.absent(),
    this.gamesPlayed = const Value.absent(),
  });
  MeetParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required int meetId,
    required int playerId,
    this.arrivalOrder = const Value.absent(),
    this.checkedInAt = const Value.absent(),
    this.gamesPlayed = const Value.absent(),
  }) : meetId = Value(meetId),
       playerId = Value(playerId);
  static Insertable<MeetParticipant> custom({
    Expression<int>? id,
    Expression<int>? meetId,
    Expression<int>? playerId,
    Expression<int>? arrivalOrder,
    Expression<DateTime>? checkedInAt,
    Expression<int>? gamesPlayed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetId != null) 'meet_id': meetId,
      if (playerId != null) 'player_id': playerId,
      if (arrivalOrder != null) 'arrival_order': arrivalOrder,
      if (checkedInAt != null) 'checked_in_at': checkedInAt,
      if (gamesPlayed != null) 'games_played': gamesPlayed,
    });
  }

  MeetParticipantsCompanion copyWith({
    Value<int>? id,
    Value<int>? meetId,
    Value<int>? playerId,
    Value<int?>? arrivalOrder,
    Value<DateTime?>? checkedInAt,
    Value<int>? gamesPlayed,
  }) {
    return MeetParticipantsCompanion(
      id: id ?? this.id,
      meetId: meetId ?? this.meetId,
      playerId: playerId ?? this.playerId,
      arrivalOrder: arrivalOrder ?? this.arrivalOrder,
      checkedInAt: checkedInAt ?? this.checkedInAt,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (meetId.present) {
      map['meet_id'] = Variable<int>(meetId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (arrivalOrder.present) {
      map['arrival_order'] = Variable<int>(arrivalOrder.value);
    }
    if (checkedInAt.present) {
      map['checked_in_at'] = Variable<DateTime>(checkedInAt.value);
    }
    if (gamesPlayed.present) {
      map['games_played'] = Variable<int>(gamesPlayed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('meetId: $meetId, ')
          ..write('playerId: $playerId, ')
          ..write('arrivalOrder: $arrivalOrder, ')
          ..write('checkedInAt: $checkedInAt, ')
          ..write('gamesPlayed: $gamesPlayed')
          ..write(')'))
        .toString();
  }
}

class $MatchRecordsTable extends MatchRecords
    with TableInfo<$MatchRecordsTable, MatchRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _meetIdMeta = const VerificationMeta('meetId');
  @override
  late final GeneratedColumn<int> meetId = GeneratedColumn<int>(
    'meet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _courtNumberMeta = const VerificationMeta(
    'courtNumber',
  );
  @override
  late final GeneratedColumn<int> courtNumber = GeneratedColumn<int>(
    'court_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _team1Player1IdMeta = const VerificationMeta(
    'team1Player1Id',
  );
  @override
  late final GeneratedColumn<int> team1Player1Id = GeneratedColumn<int>(
    'team1_player1_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meet_participants (id)',
    ),
  );
  static const VerificationMeta _team1Player2IdMeta = const VerificationMeta(
    'team1Player2Id',
  );
  @override
  late final GeneratedColumn<int> team1Player2Id = GeneratedColumn<int>(
    'team1_player2_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meet_participants (id)',
    ),
  );
  static const VerificationMeta _team2Player1IdMeta = const VerificationMeta(
    'team2Player1Id',
  );
  @override
  late final GeneratedColumn<int> team2Player1Id = GeneratedColumn<int>(
    'team2_player1_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meet_participants (id)',
    ),
  );
  static const VerificationMeta _team2Player2IdMeta = const VerificationMeta(
    'team2Player2Id',
  );
  @override
  late final GeneratedColumn<int> team2Player2Id = GeneratedColumn<int>(
    'team2_player2_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meet_participants (id)',
    ),
  );
  static const VerificationMeta _team1ScoreMeta = const VerificationMeta(
    'team1Score',
  );
  @override
  late final GeneratedColumn<int> team1Score = GeneratedColumn<int>(
    'team1_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _team2ScoreMeta = const VerificationMeta(
    'team2Score',
  );
  @override
  late final GeneratedColumn<int> team2Score = GeneratedColumn<int>(
    'team2_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetId,
    courtNumber,
    team1Player1Id,
    team1Player2Id,
    team2Player1Id,
    team2Player2Id,
    team1Score,
    team2Score,
    status,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meet_id')) {
      context.handle(
        _meetIdMeta,
        meetId.isAcceptableOrUnknown(data['meet_id']!, _meetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetIdMeta);
    }
    if (data.containsKey('court_number')) {
      context.handle(
        _courtNumberMeta,
        courtNumber.isAcceptableOrUnknown(
          data['court_number']!,
          _courtNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courtNumberMeta);
    }
    if (data.containsKey('team1_player1_id')) {
      context.handle(
        _team1Player1IdMeta,
        team1Player1Id.isAcceptableOrUnknown(
          data['team1_player1_id']!,
          _team1Player1IdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_team1Player1IdMeta);
    }
    if (data.containsKey('team1_player2_id')) {
      context.handle(
        _team1Player2IdMeta,
        team1Player2Id.isAcceptableOrUnknown(
          data['team1_player2_id']!,
          _team1Player2IdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_team1Player2IdMeta);
    }
    if (data.containsKey('team2_player1_id')) {
      context.handle(
        _team2Player1IdMeta,
        team2Player1Id.isAcceptableOrUnknown(
          data['team2_player1_id']!,
          _team2Player1IdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_team2Player1IdMeta);
    }
    if (data.containsKey('team2_player2_id')) {
      context.handle(
        _team2Player2IdMeta,
        team2Player2Id.isAcceptableOrUnknown(
          data['team2_player2_id']!,
          _team2Player2IdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_team2Player2IdMeta);
    }
    if (data.containsKey('team1_score')) {
      context.handle(
        _team1ScoreMeta,
        team1Score.isAcceptableOrUnknown(data['team1_score']!, _team1ScoreMeta),
      );
    }
    if (data.containsKey('team2_score')) {
      context.handle(
        _team2ScoreMeta,
        team2Score.isAcceptableOrUnknown(data['team2_score']!, _team2ScoreMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      meetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meet_id'],
      )!,
      courtNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}court_number'],
      )!,
      team1Player1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team1_player1_id'],
      )!,
      team1Player2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team1_player2_id'],
      )!,
      team2Player1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team2_player1_id'],
      )!,
      team2Player2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team2_player2_id'],
      )!,
      team1Score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team1_score'],
      ),
      team2Score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team2_score'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $MatchRecordsTable createAlias(String alias) {
    return $MatchRecordsTable(attachedDatabase, alias);
  }
}

class MatchRecord extends DataClass implements Insertable<MatchRecord> {
  final int id;
  final int meetId;
  final int courtNumber;
  final int team1Player1Id;
  final int team1Player2Id;
  final int team2Player1Id;
  final int team2Player2Id;
  final int? team1Score;
  final int? team2Score;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;
  const MatchRecord({
    required this.id,
    required this.meetId,
    required this.courtNumber,
    required this.team1Player1Id,
    required this.team1Player2Id,
    required this.team2Player1Id,
    required this.team2Player2Id,
    this.team1Score,
    this.team2Score,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meet_id'] = Variable<int>(meetId);
    map['court_number'] = Variable<int>(courtNumber);
    map['team1_player1_id'] = Variable<int>(team1Player1Id);
    map['team1_player2_id'] = Variable<int>(team1Player2Id);
    map['team2_player1_id'] = Variable<int>(team2Player1Id);
    map['team2_player2_id'] = Variable<int>(team2Player2Id);
    if (!nullToAbsent || team1Score != null) {
      map['team1_score'] = Variable<int>(team1Score);
    }
    if (!nullToAbsent || team2Score != null) {
      map['team2_score'] = Variable<int>(team2Score);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  MatchRecordsCompanion toCompanion(bool nullToAbsent) {
    return MatchRecordsCompanion(
      id: Value(id),
      meetId: Value(meetId),
      courtNumber: Value(courtNumber),
      team1Player1Id: Value(team1Player1Id),
      team1Player2Id: Value(team1Player2Id),
      team2Player1Id: Value(team2Player1Id),
      team2Player2Id: Value(team2Player2Id),
      team1Score: team1Score == null && nullToAbsent
          ? const Value.absent()
          : Value(team1Score),
      team2Score: team2Score == null && nullToAbsent
          ? const Value.absent()
          : Value(team2Score),
      status: Value(status),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory MatchRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchRecord(
      id: serializer.fromJson<int>(json['id']),
      meetId: serializer.fromJson<int>(json['meetId']),
      courtNumber: serializer.fromJson<int>(json['courtNumber']),
      team1Player1Id: serializer.fromJson<int>(json['team1Player1Id']),
      team1Player2Id: serializer.fromJson<int>(json['team1Player2Id']),
      team2Player1Id: serializer.fromJson<int>(json['team2Player1Id']),
      team2Player2Id: serializer.fromJson<int>(json['team2Player2Id']),
      team1Score: serializer.fromJson<int?>(json['team1Score']),
      team2Score: serializer.fromJson<int?>(json['team2Score']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'meetId': serializer.toJson<int>(meetId),
      'courtNumber': serializer.toJson<int>(courtNumber),
      'team1Player1Id': serializer.toJson<int>(team1Player1Id),
      'team1Player2Id': serializer.toJson<int>(team1Player2Id),
      'team2Player1Id': serializer.toJson<int>(team2Player1Id),
      'team2Player2Id': serializer.toJson<int>(team2Player2Id),
      'team1Score': serializer.toJson<int?>(team1Score),
      'team2Score': serializer.toJson<int?>(team2Score),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  MatchRecord copyWith({
    int? id,
    int? meetId,
    int? courtNumber,
    int? team1Player1Id,
    int? team1Player2Id,
    int? team2Player1Id,
    int? team2Player2Id,
    Value<int?> team1Score = const Value.absent(),
    Value<int?> team2Score = const Value.absent(),
    String? status,
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => MatchRecord(
    id: id ?? this.id,
    meetId: meetId ?? this.meetId,
    courtNumber: courtNumber ?? this.courtNumber,
    team1Player1Id: team1Player1Id ?? this.team1Player1Id,
    team1Player2Id: team1Player2Id ?? this.team1Player2Id,
    team2Player1Id: team2Player1Id ?? this.team2Player1Id,
    team2Player2Id: team2Player2Id ?? this.team2Player2Id,
    team1Score: team1Score.present ? team1Score.value : this.team1Score,
    team2Score: team2Score.present ? team2Score.value : this.team2Score,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  MatchRecord copyWithCompanion(MatchRecordsCompanion data) {
    return MatchRecord(
      id: data.id.present ? data.id.value : this.id,
      meetId: data.meetId.present ? data.meetId.value : this.meetId,
      courtNumber: data.courtNumber.present
          ? data.courtNumber.value
          : this.courtNumber,
      team1Player1Id: data.team1Player1Id.present
          ? data.team1Player1Id.value
          : this.team1Player1Id,
      team1Player2Id: data.team1Player2Id.present
          ? data.team1Player2Id.value
          : this.team1Player2Id,
      team2Player1Id: data.team2Player1Id.present
          ? data.team2Player1Id.value
          : this.team2Player1Id,
      team2Player2Id: data.team2Player2Id.present
          ? data.team2Player2Id.value
          : this.team2Player2Id,
      team1Score: data.team1Score.present
          ? data.team1Score.value
          : this.team1Score,
      team2Score: data.team2Score.present
          ? data.team2Score.value
          : this.team2Score,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchRecord(')
          ..write('id: $id, ')
          ..write('meetId: $meetId, ')
          ..write('courtNumber: $courtNumber, ')
          ..write('team1Player1Id: $team1Player1Id, ')
          ..write('team1Player2Id: $team1Player2Id, ')
          ..write('team2Player1Id: $team2Player1Id, ')
          ..write('team2Player2Id: $team2Player2Id, ')
          ..write('team1Score: $team1Score, ')
          ..write('team2Score: $team2Score, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    meetId,
    courtNumber,
    team1Player1Id,
    team1Player2Id,
    team2Player1Id,
    team2Player2Id,
    team1Score,
    team2Score,
    status,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchRecord &&
          other.id == this.id &&
          other.meetId == this.meetId &&
          other.courtNumber == this.courtNumber &&
          other.team1Player1Id == this.team1Player1Id &&
          other.team1Player2Id == this.team1Player2Id &&
          other.team2Player1Id == this.team2Player1Id &&
          other.team2Player2Id == this.team2Player2Id &&
          other.team1Score == this.team1Score &&
          other.team2Score == this.team2Score &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class MatchRecordsCompanion extends UpdateCompanion<MatchRecord> {
  final Value<int> id;
  final Value<int> meetId;
  final Value<int> courtNumber;
  final Value<int> team1Player1Id;
  final Value<int> team1Player2Id;
  final Value<int> team2Player1Id;
  final Value<int> team2Player2Id;
  final Value<int?> team1Score;
  final Value<int?> team2Score;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  const MatchRecordsCompanion({
    this.id = const Value.absent(),
    this.meetId = const Value.absent(),
    this.courtNumber = const Value.absent(),
    this.team1Player1Id = const Value.absent(),
    this.team1Player2Id = const Value.absent(),
    this.team2Player1Id = const Value.absent(),
    this.team2Player2Id = const Value.absent(),
    this.team1Score = const Value.absent(),
    this.team2Score = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  MatchRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int meetId,
    required int courtNumber,
    required int team1Player1Id,
    required int team1Player2Id,
    required int team2Player1Id,
    required int team2Player2Id,
    this.team1Score = const Value.absent(),
    this.team2Score = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : meetId = Value(meetId),
       courtNumber = Value(courtNumber),
       team1Player1Id = Value(team1Player1Id),
       team1Player2Id = Value(team1Player2Id),
       team2Player1Id = Value(team2Player1Id),
       team2Player2Id = Value(team2Player2Id);
  static Insertable<MatchRecord> custom({
    Expression<int>? id,
    Expression<int>? meetId,
    Expression<int>? courtNumber,
    Expression<int>? team1Player1Id,
    Expression<int>? team1Player2Id,
    Expression<int>? team2Player1Id,
    Expression<int>? team2Player2Id,
    Expression<int>? team1Score,
    Expression<int>? team2Score,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetId != null) 'meet_id': meetId,
      if (courtNumber != null) 'court_number': courtNumber,
      if (team1Player1Id != null) 'team1_player1_id': team1Player1Id,
      if (team1Player2Id != null) 'team1_player2_id': team1Player2Id,
      if (team2Player1Id != null) 'team2_player1_id': team2Player1Id,
      if (team2Player2Id != null) 'team2_player2_id': team2Player2Id,
      if (team1Score != null) 'team1_score': team1Score,
      if (team2Score != null) 'team2_score': team2Score,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  MatchRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? meetId,
    Value<int>? courtNumber,
    Value<int>? team1Player1Id,
    Value<int>? team1Player2Id,
    Value<int>? team2Player1Id,
    Value<int>? team2Player2Id,
    Value<int?>? team1Score,
    Value<int?>? team2Score,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
  }) {
    return MatchRecordsCompanion(
      id: id ?? this.id,
      meetId: meetId ?? this.meetId,
      courtNumber: courtNumber ?? this.courtNumber,
      team1Player1Id: team1Player1Id ?? this.team1Player1Id,
      team1Player2Id: team1Player2Id ?? this.team1Player2Id,
      team2Player1Id: team2Player1Id ?? this.team2Player1Id,
      team2Player2Id: team2Player2Id ?? this.team2Player2Id,
      team1Score: team1Score ?? this.team1Score,
      team2Score: team2Score ?? this.team2Score,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (meetId.present) {
      map['meet_id'] = Variable<int>(meetId.value);
    }
    if (courtNumber.present) {
      map['court_number'] = Variable<int>(courtNumber.value);
    }
    if (team1Player1Id.present) {
      map['team1_player1_id'] = Variable<int>(team1Player1Id.value);
    }
    if (team1Player2Id.present) {
      map['team1_player2_id'] = Variable<int>(team1Player2Id.value);
    }
    if (team2Player1Id.present) {
      map['team2_player1_id'] = Variable<int>(team2Player1Id.value);
    }
    if (team2Player2Id.present) {
      map['team2_player2_id'] = Variable<int>(team2Player2Id.value);
    }
    if (team1Score.present) {
      map['team1_score'] = Variable<int>(team1Score.value);
    }
    if (team2Score.present) {
      map['team2_score'] = Variable<int>(team2Score.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchRecordsCompanion(')
          ..write('id: $id, ')
          ..write('meetId: $meetId, ')
          ..write('courtNumber: $courtNumber, ')
          ..write('team1Player1Id: $team1Player1Id, ')
          ..write('team1Player2Id: $team1Player2Id, ')
          ..write('team2Player1Id: $team2Player1Id, ')
          ..write('team2Player2Id: $team2Player2Id, ')
          ..write('team1Score: $team1Score, ')
          ..write('team2Score: $team2Score, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $MeetsTable meets = $MeetsTable(this);
  late final $MeetParticipantsTable meetParticipants = $MeetParticipantsTable(
    this,
  );
  late final $MatchRecordsTable matchRecords = $MatchRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    players,
    meets,
    meetParticipants,
    matchRecords,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meet_participants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'players',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meet_participants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('match_records', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MeetParticipantsTable, List<MeetParticipant>>
  _meetParticipantsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meetParticipants,
    aliasName: 'players__id__meet_participants__player_id',
  );

  $$MeetParticipantsTableProcessedTableManager get meetParticipantsRefs {
    final manager = $$MeetParticipantsTableTableManager(
      $_db,
      $_db.meetParticipants,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _meetParticipantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> meetParticipantsRefs(
    Expression<bool> Function($$MeetParticipantsTableFilterComposer f) f,
  ) {
    final $$MeetParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> meetParticipantsRefs<T extends Object>(
    Expression<T> Function($$MeetParticipantsTableAnnotationComposer a) f,
  ) {
    final $$MeetParticipantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({bool meetParticipantsRefs})
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayersCompanion(id: id, name: name, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({meetParticipantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (meetParticipantsRefs) db.meetParticipants,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (meetParticipantsRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      MeetParticipant
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._meetParticipantsRefsTable(db),
                      managerFromTypedResult: (p0) => $$PlayersTableReferences(
                        db,
                        table,
                        p0,
                      ).meetParticipantsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.playerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({bool meetParticipantsRefs})
    >;
typedef $$MeetsTableCreateCompanionBuilder =
    MeetsCompanion Function({
      Value<int> id,
      required String name,
      required DateTime scheduledAt,
      required int durationMinutes,
      required String location,
      Value<int> courtCount,
      Value<DateTime> createdAt,
    });
typedef $$MeetsTableUpdateCompanionBuilder =
    MeetsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> scheduledAt,
      Value<int> durationMinutes,
      Value<String> location,
      Value<int> courtCount,
      Value<DateTime> createdAt,
    });

final class $$MeetsTableReferences
    extends BaseReferences<_$AppDatabase, $MeetsTable, Meet> {
  $$MeetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MeetParticipantsTable, List<MeetParticipant>>
  _meetParticipantsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meetParticipants,
    aliasName: 'meets__id__meet_participants__meet_id',
  );

  $$MeetParticipantsTableProcessedTableManager get meetParticipantsRefs {
    final manager = $$MeetParticipantsTableTableManager(
      $_db,
      $_db.meetParticipants,
    ).filter((f) => f.meetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _meetParticipantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchRecordsTable, List<MatchRecord>>
  _matchRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchRecords,
    aliasName: 'meets__id__match_records__meet_id',
  );

  $$MatchRecordsTableProcessedTableManager get matchRecordsRefs {
    final manager = $$MatchRecordsTableTableManager(
      $_db,
      $_db.matchRecords,
    ).filter((f) => f.meetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MeetsTableFilterComposer extends Composer<_$AppDatabase, $MeetsTable> {
  $$MeetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courtCount => $composableBuilder(
    column: $table.courtCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> meetParticipantsRefs(
    Expression<bool> Function($$MeetParticipantsTableFilterComposer f) f,
  ) {
    final $$MeetParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.meetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> matchRecordsRefs(
    Expression<bool> Function($$MatchRecordsTableFilterComposer f) f,
  ) {
    final $$MatchRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.meetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableFilterComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetsTable> {
  $$MeetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courtCount => $composableBuilder(
    column: $table.courtCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MeetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetsTable> {
  $$MeetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get courtCount => $composableBuilder(
    column: $table.courtCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> meetParticipantsRefs<T extends Object>(
    Expression<T> Function($$MeetParticipantsTableAnnotationComposer a) f,
  ) {
    final $$MeetParticipantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.meetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> matchRecordsRefs<T extends Object>(
    Expression<T> Function($$MatchRecordsTableAnnotationComposer a) f,
  ) {
    final $$MatchRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.meetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetsTable,
          Meet,
          $$MeetsTableFilterComposer,
          $$MeetsTableOrderingComposer,
          $$MeetsTableAnnotationComposer,
          $$MeetsTableCreateCompanionBuilder,
          $$MeetsTableUpdateCompanionBuilder,
          (Meet, $$MeetsTableReferences),
          Meet,
          PrefetchHooks Function({
            bool meetParticipantsRefs,
            bool matchRecordsRefs,
          })
        > {
  $$MeetsTableTableManager(_$AppDatabase db, $MeetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<int> courtCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MeetsCompanion(
                id: id,
                name: name,
                scheduledAt: scheduledAt,
                durationMinutes: durationMinutes,
                location: location,
                courtCount: courtCount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime scheduledAt,
                required int durationMinutes,
                required String location,
                Value<int> courtCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MeetsCompanion.insert(
                id: id,
                name: name,
                scheduledAt: scheduledAt,
                durationMinutes: durationMinutes,
                location: location,
                courtCount: courtCount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$MeetsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({meetParticipantsRefs = false, matchRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (meetParticipantsRefs) db.meetParticipants,
                    if (matchRecordsRefs) db.matchRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (meetParticipantsRefs)
                        await $_getPrefetchedData<
                          Meet,
                          $MeetsTable,
                          MeetParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$MeetsTableReferences
                              ._meetParticipantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetsTableReferences(
                                db,
                                table,
                                p0,
                              ).meetParticipantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.meetId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (matchRecordsRefs)
                        await $_getPrefetchedData<
                          Meet,
                          $MeetsTable,
                          MatchRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MeetsTableReferences
                              ._matchRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetsTableReferences(
                                db,
                                table,
                                p0,
                              ).matchRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.meetId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MeetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetsTable,
      Meet,
      $$MeetsTableFilterComposer,
      $$MeetsTableOrderingComposer,
      $$MeetsTableAnnotationComposer,
      $$MeetsTableCreateCompanionBuilder,
      $$MeetsTableUpdateCompanionBuilder,
      (Meet, $$MeetsTableReferences),
      Meet,
      PrefetchHooks Function({bool meetParticipantsRefs, bool matchRecordsRefs})
    >;
typedef $$MeetParticipantsTableCreateCompanionBuilder =
    MeetParticipantsCompanion Function({
      Value<int> id,
      required int meetId,
      required int playerId,
      Value<int?> arrivalOrder,
      Value<DateTime?> checkedInAt,
      Value<int> gamesPlayed,
    });
typedef $$MeetParticipantsTableUpdateCompanionBuilder =
    MeetParticipantsCompanion Function({
      Value<int> id,
      Value<int> meetId,
      Value<int> playerId,
      Value<int?> arrivalOrder,
      Value<DateTime?> checkedInAt,
      Value<int> gamesPlayed,
    });

final class $$MeetParticipantsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MeetParticipantsTable, MeetParticipant> {
  $$MeetParticipantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MeetsTable _meetIdTable(_$AppDatabase db) =>
      db.meets.createAlias('meet_participants__meet_id__meets__id');

  $$MeetsTableProcessedTableManager get meetId {
    final $_column = $_itemColumn<int>('meet_id')!;

    final manager = $$MeetsTableTableManager(
      $_db,
      $_db.meets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias('meet_participants__player_id__players__id');

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MatchRecordsTable, List<MatchRecord>>
  _asTeam1Player1Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchRecords,
    aliasName: 'meet_participants__id__match_records__team1_player1_id',
  );

  $$MatchRecordsTableProcessedTableManager get asTeam1Player1 {
    final manager = $$MatchRecordsTableTableManager(
      $_db,
      $_db.matchRecords,
    ).filter((f) => f.team1Player1Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_asTeam1Player1Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchRecordsTable, List<MatchRecord>>
  _asTeam1Player2Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchRecords,
    aliasName: 'meet_participants__id__match_records__team1_player2_id',
  );

  $$MatchRecordsTableProcessedTableManager get asTeam1Player2 {
    final manager = $$MatchRecordsTableTableManager(
      $_db,
      $_db.matchRecords,
    ).filter((f) => f.team1Player2Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_asTeam1Player2Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchRecordsTable, List<MatchRecord>>
  _asTeam2Player1Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchRecords,
    aliasName: 'meet_participants__id__match_records__team2_player1_id',
  );

  $$MatchRecordsTableProcessedTableManager get asTeam2Player1 {
    final manager = $$MatchRecordsTableTableManager(
      $_db,
      $_db.matchRecords,
    ).filter((f) => f.team2Player1Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_asTeam2Player1Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchRecordsTable, List<MatchRecord>>
  _asTeam2Player2Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchRecords,
    aliasName: 'meet_participants__id__match_records__team2_player2_id',
  );

  $$MatchRecordsTableProcessedTableManager get asTeam2Player2 {
    final manager = $$MatchRecordsTableTableManager(
      $_db,
      $_db.matchRecords,
    ).filter((f) => f.team2Player2Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_asTeam2Player2Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MeetParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $MeetParticipantsTable> {
  $$MeetParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get arrivalOrder => $composableBuilder(
    column: $table.arrivalOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkedInAt => $composableBuilder(
    column: $table.checkedInAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gamesPlayed => $composableBuilder(
    column: $table.gamesPlayed,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetsTableFilterComposer get meetId {
    final $$MeetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetId,
      referencedTable: $db.meets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetsTableFilterComposer(
            $db: $db,
            $table: $db.meets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> asTeam1Player1(
    Expression<bool> Function($$MatchRecordsTableFilterComposer f) f,
  ) {
    final $$MatchRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team1Player1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableFilterComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> asTeam1Player2(
    Expression<bool> Function($$MatchRecordsTableFilterComposer f) f,
  ) {
    final $$MatchRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team1Player2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableFilterComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> asTeam2Player1(
    Expression<bool> Function($$MatchRecordsTableFilterComposer f) f,
  ) {
    final $$MatchRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team2Player1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableFilterComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> asTeam2Player2(
    Expression<bool> Function($$MatchRecordsTableFilterComposer f) f,
  ) {
    final $$MatchRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team2Player2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableFilterComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetParticipantsTable> {
  $$MeetParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get arrivalOrder => $composableBuilder(
    column: $table.arrivalOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkedInAt => $composableBuilder(
    column: $table.checkedInAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gamesPlayed => $composableBuilder(
    column: $table.gamesPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetsTableOrderingComposer get meetId {
    final $$MeetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetId,
      referencedTable: $db.meets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetsTableOrderingComposer(
            $db: $db,
            $table: $db.meets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeetParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetParticipantsTable> {
  $$MeetParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get arrivalOrder => $composableBuilder(
    column: $table.arrivalOrder,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkedInAt => $composableBuilder(
    column: $table.checkedInAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get gamesPlayed => $composableBuilder(
    column: $table.gamesPlayed,
    builder: (column) => column,
  );

  $$MeetsTableAnnotationComposer get meetId {
    final $$MeetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetId,
      referencedTable: $db.meets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetsTableAnnotationComposer(
            $db: $db,
            $table: $db.meets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> asTeam1Player1<T extends Object>(
    Expression<T> Function($$MatchRecordsTableAnnotationComposer a) f,
  ) {
    final $$MatchRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team1Player1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> asTeam1Player2<T extends Object>(
    Expression<T> Function($$MatchRecordsTableAnnotationComposer a) f,
  ) {
    final $$MatchRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team1Player2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> asTeam2Player1<T extends Object>(
    Expression<T> Function($$MatchRecordsTableAnnotationComposer a) f,
  ) {
    final $$MatchRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team2Player1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> asTeam2Player2<T extends Object>(
    Expression<T> Function($$MatchRecordsTableAnnotationComposer a) f,
  ) {
    final $$MatchRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchRecords,
      getReferencedColumn: (t) => t.team2Player2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.matchRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetParticipantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetParticipantsTable,
          MeetParticipant,
          $$MeetParticipantsTableFilterComposer,
          $$MeetParticipantsTableOrderingComposer,
          $$MeetParticipantsTableAnnotationComposer,
          $$MeetParticipantsTableCreateCompanionBuilder,
          $$MeetParticipantsTableUpdateCompanionBuilder,
          (MeetParticipant, $$MeetParticipantsTableReferences),
          MeetParticipant,
          PrefetchHooks Function({
            bool meetId,
            bool playerId,
            bool asTeam1Player1,
            bool asTeam1Player2,
            bool asTeam2Player1,
            bool asTeam2Player2,
          })
        > {
  $$MeetParticipantsTableTableManager(
    _$AppDatabase db,
    $MeetParticipantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetParticipantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetParticipantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetParticipantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> meetId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int?> arrivalOrder = const Value.absent(),
                Value<DateTime?> checkedInAt = const Value.absent(),
                Value<int> gamesPlayed = const Value.absent(),
              }) => MeetParticipantsCompanion(
                id: id,
                meetId: meetId,
                playerId: playerId,
                arrivalOrder: arrivalOrder,
                checkedInAt: checkedInAt,
                gamesPlayed: gamesPlayed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int meetId,
                required int playerId,
                Value<int?> arrivalOrder = const Value.absent(),
                Value<DateTime?> checkedInAt = const Value.absent(),
                Value<int> gamesPlayed = const Value.absent(),
              }) => MeetParticipantsCompanion.insert(
                id: id,
                meetId: meetId,
                playerId: playerId,
                arrivalOrder: arrivalOrder,
                checkedInAt: checkedInAt,
                gamesPlayed: gamesPlayed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MeetParticipantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                meetId = false,
                playerId = false,
                asTeam1Player1 = false,
                asTeam1Player2 = false,
                asTeam2Player1 = false,
                asTeam2Player2 = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (asTeam1Player1) db.matchRecords,
                    if (asTeam1Player2) db.matchRecords,
                    if (asTeam2Player1) db.matchRecords,
                    if (asTeam2Player2) db.matchRecords,
                  ],
                  addJoins:
                      <
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
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (meetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.meetId,
                                    referencedTable:
                                        $$MeetParticipantsTableReferences
                                            ._meetIdTable(db),
                                    referencedColumn:
                                        $$MeetParticipantsTableReferences
                                            ._meetIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (playerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerId,
                                    referencedTable:
                                        $$MeetParticipantsTableReferences
                                            ._playerIdTable(db),
                                    referencedColumn:
                                        $$MeetParticipantsTableReferences
                                            ._playerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (asTeam1Player1)
                        await $_getPrefetchedData<
                          MeetParticipant,
                          $MeetParticipantsTable,
                          MatchRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MeetParticipantsTableReferences
                              ._asTeam1Player1Table(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).asTeam1Player1,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.team1Player1Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (asTeam1Player2)
                        await $_getPrefetchedData<
                          MeetParticipant,
                          $MeetParticipantsTable,
                          MatchRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MeetParticipantsTableReferences
                              ._asTeam1Player2Table(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).asTeam1Player2,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.team1Player2Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (asTeam2Player1)
                        await $_getPrefetchedData<
                          MeetParticipant,
                          $MeetParticipantsTable,
                          MatchRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MeetParticipantsTableReferences
                              ._asTeam2Player1Table(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).asTeam2Player1,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.team2Player1Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (asTeam2Player2)
                        await $_getPrefetchedData<
                          MeetParticipant,
                          $MeetParticipantsTable,
                          MatchRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MeetParticipantsTableReferences
                              ._asTeam2Player2Table(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).asTeam2Player2,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.team2Player2Id == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MeetParticipantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetParticipantsTable,
      MeetParticipant,
      $$MeetParticipantsTableFilterComposer,
      $$MeetParticipantsTableOrderingComposer,
      $$MeetParticipantsTableAnnotationComposer,
      $$MeetParticipantsTableCreateCompanionBuilder,
      $$MeetParticipantsTableUpdateCompanionBuilder,
      (MeetParticipant, $$MeetParticipantsTableReferences),
      MeetParticipant,
      PrefetchHooks Function({
        bool meetId,
        bool playerId,
        bool asTeam1Player1,
        bool asTeam1Player2,
        bool asTeam2Player1,
        bool asTeam2Player2,
      })
    >;
typedef $$MatchRecordsTableCreateCompanionBuilder =
    MatchRecordsCompanion Function({
      Value<int> id,
      required int meetId,
      required int courtNumber,
      required int team1Player1Id,
      required int team1Player2Id,
      required int team2Player1Id,
      required int team2Player2Id,
      Value<int?> team1Score,
      Value<int?> team2Score,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });
typedef $$MatchRecordsTableUpdateCompanionBuilder =
    MatchRecordsCompanion Function({
      Value<int> id,
      Value<int> meetId,
      Value<int> courtNumber,
      Value<int> team1Player1Id,
      Value<int> team1Player2Id,
      Value<int> team2Player1Id,
      Value<int> team2Player2Id,
      Value<int?> team1Score,
      Value<int?> team2Score,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
    });

final class $$MatchRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $MatchRecordsTable, MatchRecord> {
  $$MatchRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MeetsTable _meetIdTable(_$AppDatabase db) =>
      db.meets.createAlias('match_records__meet_id__meets__id');

  $$MeetsTableProcessedTableManager get meetId {
    final $_column = $_itemColumn<int>('meet_id')!;

    final manager = $$MeetsTableTableManager(
      $_db,
      $_db.meets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MeetParticipantsTable _team1Player1IdTable(_$AppDatabase db) => db
      .meetParticipants
      .createAlias('match_records__team1_player1_id__meet_participants__id');

  $$MeetParticipantsTableProcessedTableManager get team1Player1Id {
    final $_column = $_itemColumn<int>('team1_player1_id')!;

    final manager = $$MeetParticipantsTableTableManager(
      $_db,
      $_db.meetParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_team1Player1IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MeetParticipantsTable _team1Player2IdTable(_$AppDatabase db) => db
      .meetParticipants
      .createAlias('match_records__team1_player2_id__meet_participants__id');

  $$MeetParticipantsTableProcessedTableManager get team1Player2Id {
    final $_column = $_itemColumn<int>('team1_player2_id')!;

    final manager = $$MeetParticipantsTableTableManager(
      $_db,
      $_db.meetParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_team1Player2IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MeetParticipantsTable _team2Player1IdTable(_$AppDatabase db) => db
      .meetParticipants
      .createAlias('match_records__team2_player1_id__meet_participants__id');

  $$MeetParticipantsTableProcessedTableManager get team2Player1Id {
    final $_column = $_itemColumn<int>('team2_player1_id')!;

    final manager = $$MeetParticipantsTableTableManager(
      $_db,
      $_db.meetParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_team2Player1IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MeetParticipantsTable _team2Player2IdTable(_$AppDatabase db) => db
      .meetParticipants
      .createAlias('match_records__team2_player2_id__meet_participants__id');

  $$MeetParticipantsTableProcessedTableManager get team2Player2Id {
    final $_column = $_itemColumn<int>('team2_player2_id')!;

    final manager = $$MeetParticipantsTableTableManager(
      $_db,
      $_db.meetParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_team2Player2IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MatchRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MatchRecordsTable> {
  $$MatchRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courtNumber => $composableBuilder(
    column: $table.courtNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get team1Score => $composableBuilder(
    column: $table.team1Score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get team2Score => $composableBuilder(
    column: $table.team2Score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetsTableFilterComposer get meetId {
    final $$MeetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetId,
      referencedTable: $db.meets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetsTableFilterComposer(
            $db: $db,
            $table: $db.meets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableFilterComposer get team1Player1Id {
    final $$MeetParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team1Player1Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableFilterComposer get team1Player2Id {
    final $$MeetParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team1Player2Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableFilterComposer get team2Player1Id {
    final $$MeetParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team2Player1Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableFilterComposer get team2Player2Id {
    final $$MeetParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team2Player2Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchRecordsTable> {
  $$MatchRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courtNumber => $composableBuilder(
    column: $table.courtNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get team1Score => $composableBuilder(
    column: $table.team1Score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get team2Score => $composableBuilder(
    column: $table.team2Score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetsTableOrderingComposer get meetId {
    final $$MeetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetId,
      referencedTable: $db.meets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetsTableOrderingComposer(
            $db: $db,
            $table: $db.meets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableOrderingComposer get team1Player1Id {
    final $$MeetParticipantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team1Player1Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableOrderingComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableOrderingComposer get team1Player2Id {
    final $$MeetParticipantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team1Player2Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableOrderingComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableOrderingComposer get team2Player1Id {
    final $$MeetParticipantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team2Player1Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableOrderingComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableOrderingComposer get team2Player2Id {
    final $$MeetParticipantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team2Player2Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableOrderingComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchRecordsTable> {
  $$MatchRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get courtNumber => $composableBuilder(
    column: $table.courtNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get team1Score => $composableBuilder(
    column: $table.team1Score,
    builder: (column) => column,
  );

  GeneratedColumn<int> get team2Score => $composableBuilder(
    column: $table.team2Score,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$MeetsTableAnnotationComposer get meetId {
    final $$MeetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetId,
      referencedTable: $db.meets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetsTableAnnotationComposer(
            $db: $db,
            $table: $db.meets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableAnnotationComposer get team1Player1Id {
    final $$MeetParticipantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team1Player1Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableAnnotationComposer get team1Player2Id {
    final $$MeetParticipantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team1Player2Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableAnnotationComposer get team2Player1Id {
    final $$MeetParticipantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team2Player1Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeetParticipantsTableAnnotationComposer get team2Player2Id {
    final $$MeetParticipantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.team2Player2Id,
      referencedTable: $db.meetParticipants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetParticipantsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchRecordsTable,
          MatchRecord,
          $$MatchRecordsTableFilterComposer,
          $$MatchRecordsTableOrderingComposer,
          $$MatchRecordsTableAnnotationComposer,
          $$MatchRecordsTableCreateCompanionBuilder,
          $$MatchRecordsTableUpdateCompanionBuilder,
          (MatchRecord, $$MatchRecordsTableReferences),
          MatchRecord,
          PrefetchHooks Function({
            bool meetId,
            bool team1Player1Id,
            bool team1Player2Id,
            bool team2Player1Id,
            bool team2Player2Id,
          })
        > {
  $$MatchRecordsTableTableManager(_$AppDatabase db, $MatchRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> meetId = const Value.absent(),
                Value<int> courtNumber = const Value.absent(),
                Value<int> team1Player1Id = const Value.absent(),
                Value<int> team1Player2Id = const Value.absent(),
                Value<int> team2Player1Id = const Value.absent(),
                Value<int> team2Player2Id = const Value.absent(),
                Value<int?> team1Score = const Value.absent(),
                Value<int?> team2Score = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => MatchRecordsCompanion(
                id: id,
                meetId: meetId,
                courtNumber: courtNumber,
                team1Player1Id: team1Player1Id,
                team1Player2Id: team1Player2Id,
                team2Player1Id: team2Player1Id,
                team2Player2Id: team2Player2Id,
                team1Score: team1Score,
                team2Score: team2Score,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int meetId,
                required int courtNumber,
                required int team1Player1Id,
                required int team1Player2Id,
                required int team2Player1Id,
                required int team2Player2Id,
                Value<int?> team1Score = const Value.absent(),
                Value<int?> team2Score = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => MatchRecordsCompanion.insert(
                id: id,
                meetId: meetId,
                courtNumber: courtNumber,
                team1Player1Id: team1Player1Id,
                team1Player2Id: team1Player2Id,
                team2Player1Id: team2Player1Id,
                team2Player2Id: team2Player2Id,
                team1Score: team1Score,
                team2Score: team2Score,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                meetId = false,
                team1Player1Id = false,
                team1Player2Id = false,
                team2Player1Id = false,
                team2Player2Id = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (meetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.meetId,
                                    referencedTable:
                                        $$MatchRecordsTableReferences
                                            ._meetIdTable(db),
                                    referencedColumn:
                                        $$MatchRecordsTableReferences
                                            ._meetIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (team1Player1Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.team1Player1Id,
                                    referencedTable:
                                        $$MatchRecordsTableReferences
                                            ._team1Player1IdTable(db),
                                    referencedColumn:
                                        $$MatchRecordsTableReferences
                                            ._team1Player1IdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (team1Player2Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.team1Player2Id,
                                    referencedTable:
                                        $$MatchRecordsTableReferences
                                            ._team1Player2IdTable(db),
                                    referencedColumn:
                                        $$MatchRecordsTableReferences
                                            ._team1Player2IdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (team2Player1Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.team2Player1Id,
                                    referencedTable:
                                        $$MatchRecordsTableReferences
                                            ._team2Player1IdTable(db),
                                    referencedColumn:
                                        $$MatchRecordsTableReferences
                                            ._team2Player1IdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (team2Player2Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.team2Player2Id,
                                    referencedTable:
                                        $$MatchRecordsTableReferences
                                            ._team2Player2IdTable(db),
                                    referencedColumn:
                                        $$MatchRecordsTableReferences
                                            ._team2Player2IdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MatchRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchRecordsTable,
      MatchRecord,
      $$MatchRecordsTableFilterComposer,
      $$MatchRecordsTableOrderingComposer,
      $$MatchRecordsTableAnnotationComposer,
      $$MatchRecordsTableCreateCompanionBuilder,
      $$MatchRecordsTableUpdateCompanionBuilder,
      (MatchRecord, $$MatchRecordsTableReferences),
      MatchRecord,
      PrefetchHooks Function({
        bool meetId,
        bool team1Player1Id,
        bool team1Player2Id,
        bool team2Player1Id,
        bool team2Player2Id,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$MeetsTableTableManager get meets =>
      $$MeetsTableTableManager(_db, _db.meets);
  $$MeetParticipantsTableTableManager get meetParticipants =>
      $$MeetParticipantsTableTableManager(_db, _db.meetParticipants);
  $$MatchRecordsTableTableManager get matchRecords =>
      $$MatchRecordsTableTableManager(_db, _db.matchRecords);
}
