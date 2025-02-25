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
  static const VerificationMeta _amountTypeIconIdMeta =
      const VerificationMeta('amountTypeIconId');
  @override
  late final GeneratedColumn<int> amountTypeIconId = GeneratedColumn<int>(
      'amount_type_icon_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [amountTypeId, title, amountTypeIconId];
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
    if (data.containsKey('amount_type_icon_id')) {
      context.handle(
          _amountTypeIconIdMeta,
          amountTypeIconId.isAcceptableOrUnknown(
              data['amount_type_icon_id']!, _amountTypeIconIdMeta));
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
      amountTypeIconId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}amount_type_icon_id'])!,
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
  final int amountTypeIconId;
  const AmountType(
      {required this.amountTypeId,
      required this.title,
      required this.amountTypeIconId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['amount_type_id'] = Variable<int>(amountTypeId);
    map['title'] = Variable<String>(title);
    map['amount_type_icon_id'] = Variable<int>(amountTypeIconId);
    return map;
  }

  AmountTypesCompanion toCompanion(bool nullToAbsent) {
    return AmountTypesCompanion(
      amountTypeId: Value(amountTypeId),
      title: Value(title),
      amountTypeIconId: Value(amountTypeIconId),
    );
  }

  factory AmountType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AmountType(
      amountTypeId: serializer.fromJson<int>(json['amountTypeId']),
      title: serializer.fromJson<String>(json['title']),
      amountTypeIconId: serializer.fromJson<int>(json['amountTypeIconId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'amountTypeId': serializer.toJson<int>(amountTypeId),
      'title': serializer.toJson<String>(title),
      'amountTypeIconId': serializer.toJson<int>(amountTypeIconId),
    };
  }

  AmountType copyWith(
          {int? amountTypeId, String? title, int? amountTypeIconId}) =>
      AmountType(
        amountTypeId: amountTypeId ?? this.amountTypeId,
        title: title ?? this.title,
        amountTypeIconId: amountTypeIconId ?? this.amountTypeIconId,
      );
  AmountType copyWithCompanion(AmountTypesCompanion data) {
    return AmountType(
      amountTypeId: data.amountTypeId.present
          ? data.amountTypeId.value
          : this.amountTypeId,
      title: data.title.present ? data.title.value : this.title,
      amountTypeIconId: data.amountTypeIconId.present
          ? data.amountTypeIconId.value
          : this.amountTypeIconId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AmountType(')
          ..write('amountTypeId: $amountTypeId, ')
          ..write('title: $title, ')
          ..write('amountTypeIconId: $amountTypeIconId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(amountTypeId, title, amountTypeIconId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AmountType &&
          other.amountTypeId == this.amountTypeId &&
          other.title == this.title &&
          other.amountTypeIconId == this.amountTypeIconId);
}

class AmountTypesCompanion extends UpdateCompanion<AmountType> {
  final Value<int> amountTypeId;
  final Value<String> title;
  final Value<int> amountTypeIconId;
  const AmountTypesCompanion({
    this.amountTypeId = const Value.absent(),
    this.title = const Value.absent(),
    this.amountTypeIconId = const Value.absent(),
  });
  AmountTypesCompanion.insert({
    this.amountTypeId = const Value.absent(),
    required String title,
    this.amountTypeIconId = const Value.absent(),
  }) : title = Value(title);
  static Insertable<AmountType> custom({
    Expression<int>? amountTypeId,
    Expression<String>? title,
    Expression<int>? amountTypeIconId,
  }) {
    return RawValuesInsertable({
      if (amountTypeId != null) 'amount_type_id': amountTypeId,
      if (title != null) 'title': title,
      if (amountTypeIconId != null) 'amount_type_icon_id': amountTypeIconId,
    });
  }

  AmountTypesCompanion copyWith(
      {Value<int>? amountTypeId,
      Value<String>? title,
      Value<int>? amountTypeIconId}) {
    return AmountTypesCompanion(
      amountTypeId: amountTypeId ?? this.amountTypeId,
      title: title ?? this.title,
      amountTypeIconId: amountTypeIconId ?? this.amountTypeIconId,
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
    if (amountTypeIconId.present) {
      map['amount_type_icon_id'] = Variable<int>(amountTypeIconId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AmountTypesCompanion(')
          ..write('amountTypeId: $amountTypeId, ')
          ..write('title: $title, ')
          ..write('amountTypeIconId: $amountTypeIconId')
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
  Wallet copyWithCompanion(WalletsCompanion data) {
    return Wallet(
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      amountTypeId: data.amountTypeId.present
          ? data.amountTypeId.value
          : this.amountTypeId,
    );
  }

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
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AmountTypesTable amountTypes = $AmountTypesTable(this);
  late final $WalletsTable wallets = $WalletsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [amountTypes, wallets];
}

typedef $$AmountTypesTableCreateCompanionBuilder = AmountTypesCompanion
    Function({
  Value<int> amountTypeId,
  required String title,
  Value<int> amountTypeIconId,
});
typedef $$AmountTypesTableUpdateCompanionBuilder = AmountTypesCompanion
    Function({
  Value<int> amountTypeId,
  Value<String> title,
  Value<int> amountTypeIconId,
});

final class $$AmountTypesTableReferences
    extends BaseReferences<_$AppDatabase, $AmountTypesTable, AmountType> {
  $$AmountTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WalletsTable, List<Wallet>> _walletsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.wallets,
          aliasName: $_aliasNameGenerator(
              db.amountTypes.amountTypeId, db.wallets.amountTypeId));

  $$WalletsTableProcessedTableManager get walletsRefs {
    final manager = $$WalletsTableTableManager($_db, $_db.wallets).filter((f) =>
        f.amountTypeId.amountTypeId
            .sqlEquals($_itemColumn<int>('amount_type_id')!));

    final cache = $_typedResult.readTableOrNull(_walletsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AmountTypesTableFilterComposer
    extends Composer<_$AppDatabase, $AmountTypesTable> {
  $$AmountTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get amountTypeId => $composableBuilder(
      column: $table.amountTypeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountTypeIconId => $composableBuilder(
      column: $table.amountTypeIconId,
      builder: (column) => ColumnFilters(column));

  Expression<bool> walletsRefs(
      Expression<bool> Function($$WalletsTableFilterComposer f) f) {
    final $$WalletsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $db.wallets,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletsTableFilterComposer(
              $db: $db,
              $table: $db.wallets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AmountTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $AmountTypesTable> {
  $$AmountTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get amountTypeId => $composableBuilder(
      column: $table.amountTypeId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountTypeIconId => $composableBuilder(
      column: $table.amountTypeIconId,
      builder: (column) => ColumnOrderings(column));
}

class $$AmountTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AmountTypesTable> {
  $$AmountTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get amountTypeId => $composableBuilder(
      column: $table.amountTypeId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get amountTypeIconId => $composableBuilder(
      column: $table.amountTypeIconId, builder: (column) => column);

  Expression<T> walletsRefs<T extends Object>(
      Expression<T> Function($$WalletsTableAnnotationComposer a) f) {
    final $$WalletsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $db.wallets,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WalletsTableAnnotationComposer(
              $db: $db,
              $table: $db.wallets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AmountTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AmountTypesTable,
    AmountType,
    $$AmountTypesTableFilterComposer,
    $$AmountTypesTableOrderingComposer,
    $$AmountTypesTableAnnotationComposer,
    $$AmountTypesTableCreateCompanionBuilder,
    $$AmountTypesTableUpdateCompanionBuilder,
    (AmountType, $$AmountTypesTableReferences),
    AmountType,
    PrefetchHooks Function({bool walletsRefs})> {
  $$AmountTypesTableTableManager(_$AppDatabase db, $AmountTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AmountTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AmountTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AmountTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> amountTypeId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> amountTypeIconId = const Value.absent(),
          }) =>
              AmountTypesCompanion(
            amountTypeId: amountTypeId,
            title: title,
            amountTypeIconId: amountTypeIconId,
          ),
          createCompanionCallback: ({
            Value<int> amountTypeId = const Value.absent(),
            required String title,
            Value<int> amountTypeIconId = const Value.absent(),
          }) =>
              AmountTypesCompanion.insert(
            amountTypeId: amountTypeId,
            title: title,
            amountTypeIconId: amountTypeIconId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AmountTypesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({walletsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (walletsRefs) db.wallets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (walletsRefs)
                    await $_getPrefetchedData<AmountType, $AmountTypesTable,
                            Wallet>(
                        currentTable: table,
                        referencedTable:
                            $$AmountTypesTableReferences._walletsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AmountTypesTableReferences(db, table, p0)
                                .walletsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.amountTypeId == item.amountTypeId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AmountTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AmountTypesTable,
    AmountType,
    $$AmountTypesTableFilterComposer,
    $$AmountTypesTableOrderingComposer,
    $$AmountTypesTableAnnotationComposer,
    $$AmountTypesTableCreateCompanionBuilder,
    $$AmountTypesTableUpdateCompanionBuilder,
    (AmountType, $$AmountTypesTableReferences),
    AmountType,
    PrefetchHooks Function({bool walletsRefs})>;
typedef $$WalletsTableCreateCompanionBuilder = WalletsCompanion Function({
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

final class $$WalletsTableReferences
    extends BaseReferences<_$AppDatabase, $WalletsTable, Wallet> {
  $$WalletsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AmountTypesTable _amountTypeIdTable(_$AppDatabase db) =>
      db.amountTypes.createAlias($_aliasNameGenerator(
          db.wallets.amountTypeId, db.amountTypes.amountTypeId));

  $$AmountTypesTableProcessedTableManager get amountTypeId {
    final $_column = $_itemColumn<int>('amount_type_id')!;

    final manager = $$AmountTypesTableTableManager($_db, $_db.amountTypes)
        .filter((f) => f.amountTypeId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_amountTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WalletsTableFilterComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get walletId => $composableBuilder(
      column: $table.walletId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$AmountTypesTableFilterComposer get amountTypeId {
    final $$AmountTypesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $db.amountTypes,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AmountTypesTableFilterComposer(
              $db: $db,
              $table: $db.amountTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get walletId => $composableBuilder(
      column: $table.walletId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$AmountTypesTableOrderingComposer get amountTypeId {
    final $$AmountTypesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $db.amountTypes,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AmountTypesTableOrderingComposer(
              $db: $db,
              $table: $db.amountTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletsTable> {
  $$WalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get walletId =>
      $composableBuilder(column: $table.walletId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AmountTypesTableAnnotationComposer get amountTypeId {
    final $$AmountTypesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.amountTypeId,
        referencedTable: $db.amountTypes,
        getReferencedColumn: (t) => t.amountTypeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AmountTypesTableAnnotationComposer(
              $db: $db,
              $table: $db.amountTypes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WalletsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WalletsTable,
    Wallet,
    $$WalletsTableFilterComposer,
    $$WalletsTableOrderingComposer,
    $$WalletsTableAnnotationComposer,
    $$WalletsTableCreateCompanionBuilder,
    $$WalletsTableUpdateCompanionBuilder,
    (Wallet, $$WalletsTableReferences),
    Wallet,
    PrefetchHooks Function({bool amountTypeId})> {
  $$WalletsTableTableManager(_$AppDatabase db, $WalletsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
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
          createCompanionCallback: ({
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
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WalletsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({amountTypeId = false}) {
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
                      dynamic,
                      dynamic>>(state) {
                if (amountTypeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.amountTypeId,
                    referencedTable:
                        $$WalletsTableReferences._amountTypeIdTable(db),
                    referencedColumn: $$WalletsTableReferences
                        ._amountTypeIdTable(db)
                        .amountTypeId,
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

typedef $$WalletsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WalletsTable,
    Wallet,
    $$WalletsTableFilterComposer,
    $$WalletsTableOrderingComposer,
    $$WalletsTableAnnotationComposer,
    $$WalletsTableCreateCompanionBuilder,
    $$WalletsTableUpdateCompanionBuilder,
    (Wallet, $$WalletsTableReferences),
    Wallet,
    PrefetchHooks Function({bool amountTypeId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AmountTypesTableTableManager get amountTypes =>
      $$AmountTypesTableTableManager(_db, _db.amountTypes);
  $$WalletsTableTableManager get wallets =>
      $$WalletsTableTableManager(_db, _db.wallets);
}
