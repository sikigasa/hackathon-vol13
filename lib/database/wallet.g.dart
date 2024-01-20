// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// ignore_for_file: type=lint
class $AmountTypesTable extends AmountTypes
    with TableInfo<$AmountTypesTable, AmountType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AmountTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _priceTypeIdMeta =
      const VerificationMeta('priceTypeId');
  @override
  late final GeneratedColumn<int> priceTypeId = GeneratedColumn<int>(
      'price_type_id', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [priceTypeId, title];
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
    if (data.containsKey('price_type_id')) {
      context.handle(
          _priceTypeIdMeta,
          priceTypeId.isAcceptableOrUnknown(
              data['price_type_id']!, _priceTypeIdMeta));
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
  Set<GeneratedColumn> get $primaryKey => {priceTypeId};
  @override
  AmountType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AmountType(
      priceTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_type_id'])!,
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
  final int priceTypeId;
  final String title;
  const AmountType({required this.priceTypeId, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['price_type_id'] = Variable<int>(priceTypeId);
    map['title'] = Variable<String>(title);
    return map;
  }

  AmountTypesCompanion toCompanion(bool nullToAbsent) {
    return AmountTypesCompanion(
      priceTypeId: Value(priceTypeId),
      title: Value(title),
    );
  }

  factory AmountType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AmountType(
      priceTypeId: serializer.fromJson<int>(json['priceTypeId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'priceTypeId': serializer.toJson<int>(priceTypeId),
      'title': serializer.toJson<String>(title),
    };
  }

  AmountType copyWith({int? priceTypeId, String? title}) => AmountType(
        priceTypeId: priceTypeId ?? this.priceTypeId,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('AmountType(')
          ..write('priceTypeId: $priceTypeId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(priceTypeId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AmountType &&
          other.priceTypeId == this.priceTypeId &&
          other.title == this.title);
}

class AmountTypesCompanion extends UpdateCompanion<AmountType> {
  final Value<int> priceTypeId;
  final Value<String> title;
  const AmountTypesCompanion({
    this.priceTypeId = const Value.absent(),
    this.title = const Value.absent(),
  });
  AmountTypesCompanion.insert({
    this.priceTypeId = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<AmountType> custom({
    Expression<int>? priceTypeId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (priceTypeId != null) 'price_type_id': priceTypeId,
      if (title != null) 'title': title,
    });
  }

  AmountTypesCompanion copyWith(
      {Value<int>? priceTypeId, Value<String>? title}) {
    return AmountTypesCompanion(
      priceTypeId: priceTypeId ?? this.priceTypeId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (priceTypeId.present) {
      map['price_type_id'] = Variable<int>(priceTypeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AmountTypesCompanion(')
          ..write('priceTypeId: $priceTypeId, ')
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
  late final GeneratedColumn<int> walletId = GeneratedColumn<int>(
      'wallet_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountTypeIdMeta =
      const VerificationMeta('amountTypeId');
  @override
  late final GeneratedColumn<int> amountTypeId = GeneratedColumn<int>(
      'amount_type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES amount_types (price_type_id)'));
  @override
  List<GeneratedColumn> get $columns => [walletId, amount, amountTypeId];
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
          .read(DriftSqlType.int, data['${effectivePrefix}wallet_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
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
  final int walletId;
  final int amount;
  final int amountTypeId;
  const Wallet(
      {required this.walletId,
      required this.amount,
      required this.amountTypeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wallet_id'] = Variable<int>(walletId);
    map['amount'] = Variable<int>(amount);
    map['amount_type_id'] = Variable<int>(amountTypeId);
    return map;
  }

  WalletsCompanion toCompanion(bool nullToAbsent) {
    return WalletsCompanion(
      walletId: Value(walletId),
      amount: Value(amount),
      amountTypeId: Value(amountTypeId),
    );
  }

  factory Wallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wallet(
      walletId: serializer.fromJson<int>(json['walletId']),
      amount: serializer.fromJson<int>(json['amount']),
      amountTypeId: serializer.fromJson<int>(json['amountTypeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'walletId': serializer.toJson<int>(walletId),
      'amount': serializer.toJson<int>(amount),
      'amountTypeId': serializer.toJson<int>(amountTypeId),
    };
  }

  Wallet copyWith({int? walletId, int? amount, int? amountTypeId}) => Wallet(
        walletId: walletId ?? this.walletId,
        amount: amount ?? this.amount,
        amountTypeId: amountTypeId ?? this.amountTypeId,
      );
  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('walletId: $walletId, ')
          ..write('amount: $amount, ')
          ..write('amountTypeId: $amountTypeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(walletId, amount, amountTypeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.walletId == this.walletId &&
          other.amount == this.amount &&
          other.amountTypeId == this.amountTypeId);
}

class WalletsCompanion extends UpdateCompanion<Wallet> {
  final Value<int> walletId;
  final Value<int> amount;
  final Value<int> amountTypeId;
  const WalletsCompanion({
    this.walletId = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountTypeId = const Value.absent(),
  });
  WalletsCompanion.insert({
    this.walletId = const Value.absent(),
    required int amount,
    required int amountTypeId,
  })  : amount = Value(amount),
        amountTypeId = Value(amountTypeId);
  static Insertable<Wallet> custom({
    Expression<int>? walletId,
    Expression<int>? amount,
    Expression<int>? amountTypeId,
  }) {
    return RawValuesInsertable({
      if (walletId != null) 'wallet_id': walletId,
      if (amount != null) 'amount': amount,
      if (amountTypeId != null) 'amount_type_id': amountTypeId,
    });
  }

  WalletsCompanion copyWith(
      {Value<int>? walletId, Value<int>? amount, Value<int>? amountTypeId}) {
    return WalletsCompanion(
      walletId: walletId ?? this.walletId,
      amount: amount ?? this.amount,
      amountTypeId: amountTypeId ?? this.amountTypeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (walletId.present) {
      map['wallet_id'] = Variable<int>(walletId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (amountTypeId.present) {
      map['amount_type_id'] = Variable<int>(amountTypeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletsCompanion(')
          ..write('walletId: $walletId, ')
          ..write('amount: $amount, ')
          ..write('amountTypeId: $amountTypeId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $AmountTypesTable amountTypes = $AmountTypesTable(this);
  late final $WalletsTable wallets = $WalletsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [amountTypes, wallets];
}
