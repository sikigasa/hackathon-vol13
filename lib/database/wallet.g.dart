// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// ignore_for_file: type=lint
class $AmountTypesTable extends AmountTypes
    with TableInfo<$AmountTypesTable, AmountType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AmountTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _amountTypeIdMeta =
      const VerificationMeta('amountTypeId');
  @override
  late final GeneratedColumn<int> amountTypeId = GeneratedColumn<int>(
      'amount_type_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [amountTypeId, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'amount_types';
  @override
  VerificationContext validateIntegrity(Insertable<AmountType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('amount_type_id')) {
      context.handle(
          _amountTypeIdMeta,
          amountTypeId.isAcceptableOrUnknown(
              data['amount_type_id']!, _amountTypeIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {amountTypeId};
  @override
  AmountType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AmountType(
      amountTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_type_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $AmountTypesTable createAlias(String alias) {
    return $AmountTypesTable(attachedDatabase, alias);
  }
}

class AmountType extends DataClass implements Insertable<AmountType> {
  final int amountTypeId;
  final String title;
  const AmountType({required this.amountTypeId, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['amount_type_id'] = Variable<int>(amountTypeId);
    map['title'] = Variable<String>(title);
    return map;
  }

  AmountTypesCompanion toCompanion(bool nullToAbsent) {
    return AmountTypesCompanion(
      amountTypeId: Value(amountTypeId),
      title: Value(title),
    );
  }

  factory AmountType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AmountType(
      amountTypeId: serializer.fromJson<int>(json['amountTypeId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'amountTypeId': serializer.toJson<int>(amountTypeId),
      'title': serializer.toJson<String>(title),
    };
  }

  AmountType copyWith({int? amountTypeId, String? title}) => AmountType(
        amountTypeId: amountTypeId ?? this.amountTypeId,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('AmountType(')
          ..write('amountTypeId: $amountTypeId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(amountTypeId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AmountType &&
          other.amountTypeId == this.amountTypeId &&
          other.title == this.title);
}

class AmountTypesCompanion extends UpdateCompanion<AmountType> {
  final Value<int> amountTypeId;
  final Value<String> title;
  const AmountTypesCompanion({
    this.amountTypeId = const Value.absent(),
    this.title = const Value.absent(),
  });
  AmountTypesCompanion.insert({
    this.amountTypeId = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<AmountType> custom({
    Expression<int>? amountTypeId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (amountTypeId != null) 'amount_type_id': amountTypeId,
      if (title != null) 'title': title,
    });
  }

  AmountTypesCompanion copyWith(
      {Value<int>? amountTypeId, Value<String>? title}) {
    return AmountTypesCompanion(
      amountTypeId: amountTypeId ?? this.amountTypeId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (amountTypeId.present) {
      map['amount_type_id'] = Variable<int>(amountTypeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AmountTypesCompanion(')
          ..write('amountTypeId: $amountTypeId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $WalletsTable extends Wallets with TableInfo<$WalletsTable, Wallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _walletIdMeta =
      const VerificationMeta('walletId');
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
      'wallet_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v7());
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _amountTypeIdMeta =
      const VerificationMeta('amountTypeId');
  @override
  late final GeneratedColumn<int> amountTypeId = GeneratedColumn<int>(
      'amount_type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES amount_types (amount_type_id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [walletId, amount, createdAt, amountTypeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallets';
  @override
  VerificationContext validateIntegrity(Insertable<Wallet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('wallet_id')) {
      context.handle(_walletIdMeta,
          walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('amount_type_id')) {
      context.handle(
          _amountTypeIdMeta,
          amountTypeId.isAcceptableOrUnknown(
              data['amount_type_id']!, _amountTypeIdMeta));
    } else if (isInserting) {
      context.missing(_amountTypeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {walletId};
  @override
  Wallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wallet(
      walletId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wallet_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      amountTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_type_id'])!,
    );
  }

  @override
  $WalletsTable createAlias(String alias) {
    return $WalletsTable(attachedDatabase, alias);
  }
}

class Wallet extends DataClass implements Insertable<Wallet> {
  final String walletId;
  final int amount;
  final DateTime createdAt;
  final int amountTypeId;
  const Wallet(
      {required this.walletId,
      required this.amount,
      required this.createdAt,
      required this.amountTypeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wallet_id'] = Variable<String>(walletId);
    map['amount'] = Variable<int>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['amount_type_id'] = Variable<int>(amountTypeId);
    return map;
  }

  WalletsCompanion toCompanion(bool nullToAbsent) {
    return WalletsCompanion(
      walletId: Value(walletId),
      amount: Value(amount),
      createdAt: Value(createdAt),
      amountTypeId: Value(amountTypeId),
    );
  }

  factory Wallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wallet(
      walletId: serializer.fromJson<String>(json['walletId']),
      amount: serializer.fromJson<int>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      amountTypeId: serializer.fromJson<int>(json['amountTypeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'walletId': serializer.toJson<String>(walletId),
      'amount': serializer.toJson<int>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'amountTypeId': serializer.toJson<int>(amountTypeId),
    };
  }

  Wallet copyWith(
          {String? walletId,
          int? amount,
          DateTime? createdAt,
          int? amountTypeId}) =>
      Wallet(
        walletId: walletId ?? this.walletId,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        amountTypeId: amountTypeId ?? this.amountTypeId,
      );
  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('walletId: $walletId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('amountTypeId: $amountTypeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(walletId, amount, createdAt, amountTypeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.walletId == this.walletId &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt &&
          other.amountTypeId == this.amountTypeId);
}

class WalletsCompanion extends UpdateCompanion<Wallet> {
  final Value<String> walletId;
  final Value<int> amount;
  final Value<DateTime> createdAt;
  final Value<int> amountTypeId;
  final Value<int> rowid;
  const WalletsCompanion({
    this.walletId = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.amountTypeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalletsCompanion.insert({
    this.walletId = const Value.absent(),
    required int amount,
    this.createdAt = const Value.absent(),
    required int amountTypeId,
    this.rowid = const Value.absent(),
  })  : amount = Value(amount),
        amountTypeId = Value(amountTypeId);
  static Insertable<Wallet> custom({
    Expression<String>? walletId,
    Expression<int>? amount,
    Expression<DateTime>? createdAt,
    Expression<int>? amountTypeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (walletId != null) 'wallet_id': walletId,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
      if (amountTypeId != null) 'amount_type_id': amountTypeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalletsCompanion copyWith(
      {Value<String>? walletId,
      Value<int>? amount,
      Value<DateTime>? createdAt,
      Value<int>? amountTypeId,
      Value<int>? rowid}) {
    return WalletsCompanion(
      walletId: walletId ?? this.walletId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      amountTypeId: amountTypeId ?? this.amountTypeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (amountTypeId.present) {
      map['amount_type_id'] = Variable<int>(amountTypeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletsCompanion(')
          ..write('walletId: $walletId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('amountTypeId: $amountTypeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AmountTypesTable amountTypes = $AmountTypesTable(this);
  late final $WalletsTable wallets = $WalletsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [amountTypes, wallets];
}

typedef $$AmountTypesTableInsertCompanionBuilder = AmountTypesCompanion
    Function({
  Value<int> amountTypeId,
  required String title,
});
typedef $$AmountTypesTableUpdateCompanionBuilder = AmountTypesCompanion
    Function({
  Value<int> amountTypeId,
  Value<String> title,
});

class $$AmountTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AmountTypesTable,
    AmountType,
    $$AmountTypesTableFilterComposer,
    $$AmountTypesTableOrderingComposer,
    $$AmountTypesTableProcessedTableManager,
    $$AmountTypesTableInsertCompanionBuilder,
    $$AmountTypesTableUpdateCompanionBuilder> {
  $$AmountTypesTableTableManager(_$AppDatabase db, $AmountTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AmountTypesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AmountTypesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AmountTypesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> amountTypeId = const Value.absent(),
            Value<String> title = const Value.absent(),
          }) =>
              AmountTypesCompanion(
            amountTypeId: amountTypeId,
            title: title,
          ),
          getInsertCompanionBuilder: ({
            Value<int> amountTypeId = const Value.absent(),
            required String title,
          }) =>
              AmountTypesCompanion.insert(
            amountTypeId: amountTypeId,
            title: title,
          ),
        ));
}

class $$AmountTypesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AmountTypesTable,
    AmountType,
    $$AmountTypesTableFilterComposer,
    $$AmountTypesTableOrderingComposer,
    $$AmountTypesTableProcessedTableManager,
    $$AmountTypesTableInsertCompanionBuilder,
    $$AmountTypesTableUpdateCompanionBuilder> {
  $$AmountTypesTableProcessedTableManager(super.$state);
}

class $$AmountTypesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AmountTypesTable> {
  $$AmountTypesTableFilterComposer(super.$state);
  ColumnFilters<int> get amountTypeId => $state.composableBuilder(
      column: $state.table.amountTypeId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter walletsRefs(
      ComposableFilter Function($$WalletsTableFilterComposer f) f) {
    final $$WalletsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $state.db.wallets,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder, parentComposers) => $$WalletsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.wallets, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$AmountTypesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AmountTypesTable> {
  $$AmountTypesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get amountTypeId => $state.composableBuilder(
      column: $state.table.amountTypeId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WalletsTableInsertCompanionBuilder = WalletsCompanion Function({
  Value<String> walletId,
  required int amount,
  Value<DateTime> createdAt,
  required int amountTypeId,
  Value<int> rowid,
});
typedef $$WalletsTableUpdateCompanionBuilder = WalletsCompanion Function({
  Value<String> walletId,
  Value<int> amount,
  Value<DateTime> createdAt,
  Value<int> amountTypeId,
  Value<int> rowid,
});

class $$WalletsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WalletsTable,
    Wallet,
    $$WalletsTableFilterComposer,
    $$WalletsTableOrderingComposer,
    $$WalletsTableProcessedTableManager,
    $$WalletsTableInsertCompanionBuilder,
    $$WalletsTableUpdateCompanionBuilder> {
  $$WalletsTableTableManager(_$AppDatabase db, $WalletsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WalletsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WalletsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$WalletsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> walletId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> amountTypeId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WalletsCompanion(
            walletId: walletId,
            amount: amount,
            createdAt: createdAt,
            amountTypeId: amountTypeId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            Value<String> walletId = const Value.absent(),
            required int amount,
            Value<DateTime> createdAt = const Value.absent(),
            required int amountTypeId,
            Value<int> rowid = const Value.absent(),
          }) =>
              WalletsCompanion.insert(
            walletId: walletId,
            amount: amount,
            createdAt: createdAt,
            amountTypeId: amountTypeId,
            rowid: rowid,
          ),
        ));
}

class $$WalletsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WalletsTable,
    Wallet,
    $$WalletsTableFilterComposer,
    $$WalletsTableOrderingComposer,
    $$WalletsTableProcessedTableManager,
    $$WalletsTableInsertCompanionBuilder,
    $$WalletsTableUpdateCompanionBuilder> {
  $$WalletsTableProcessedTableManager(super.$state);
}

class $$WalletsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableFilterComposer(super.$state);
  ColumnFilters<String> get walletId => $state.composableBuilder(
      column: $state.table.walletId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$AmountTypesTableFilterComposer get amountTypeId {
    final $$AmountTypesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $state.db.amountTypes,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder, parentComposers) =>
            $$AmountTypesTableFilterComposer(ComposerState($state.db,
                $state.db.amountTypes, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$WalletsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get walletId => $state.composableBuilder(
      column: $state.table.walletId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$AmountTypesTableOrderingComposer get amountTypeId {
    final $$AmountTypesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $state.db.amountTypes,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder, parentComposers) =>
            $$AmountTypesTableOrderingComposer(ComposerState($state.db,
                $state.db.amountTypes, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AmountTypesTableTableManager get amountTypes =>
      $$AmountTypesTableTableManager(_db, _db.amountTypes);
  $$WalletsTableTableManager get wallets =>
      $$WalletsTableTableManager(_db, _db.wallets);
}
