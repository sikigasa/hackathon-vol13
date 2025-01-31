import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'wallet.g.dart';

final _uuid = const Uuid();

// @DataClassName('Wallet')
class Wallets extends Table {
  @override
  Set<Column> get primaryKey => {walletId};

  // TextColumn get walletId => text().unique()();
  TextColumn get walletId => text().clientDefault(() => _uuid.v7())();
  IntColumn get amount => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get amountTypeId =>
      integer().references(AmountTypes, #amountTypeId)();
}

// @DataClassName('PriceType')
class AmountTypes extends Table {
  IntColumn get amountTypeId => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
}

@DriftDatabase(tables: [Wallets, AmountTypes])
class AppDatabase extends _$AppDatabase {
  @override
  // データベースのスキーマバージョンを返す。現在は1。
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          final database = AppDatabase();
          await into(database.amountTypes)
              .insert(const AmountType(amountTypeId: 0, title: "wallet"));
          await into(database.amountTypes)
              .insert(const AmountType(amountTypeId: 1, title: "bank"));
          await into(database.amountTypes)
              .insert(const AmountType(amountTypeId: 2, title: "card"));
        },
        // onUpgrade: (m, from, to) async {
        //   if (from == 1) {
        //     await m.alterTable(TableMigration(AmountTypes));
        //   }
        // },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
  AppDatabase() : super(_openConnection());

  get walletDao => null;
}

// 新しいwalletTypeをデータベースに挿入する
Future insertAmountType(AppDatabase db, String title) {
  return db.into(db.amountTypes).insert(
        AmountTypesCompanion.insert(title: title),
      );
}

// データベースから全てのwalletTypeを取得する
Future<List<AmountType>> getAllAmountTypes(AppDatabase db) {
  return db.select(db.amountTypes).get();
}

// Stream版
Stream<List<AmountType>> watchAllAmountTypes(AppDatabase db) {
  return db.select(db.amountTypes).watch();
}

// walletTypeを更新する
Future updateAmountType(AppDatabase db, AmountType amountType) {
  return db.update(db.amountTypes).replace(amountType);
}

// walletTypeを削除する: Todo
Future deleteAmountType(AppDatabase db, AmountType amountType) {
  return db.delete(db.amountTypes).delete(amountType);
}

// データベースから全てのメモをストリームとして取得する。
// メモが追加、更新、削除されると、このストリームは新しいリストを返す。
Stream<List<Wallet>> watchAllWallets(AppDatabase db) {
  return db.select(db.wallets).watch();
}

Stream<List<Wallet>> watchAllWalletsByAmountTypeId(
    AppDatabase db, int amountTypeId) {
  return db.select(db.wallets).watch().map((wallets) =>
      wallets.where((wallet) => wallet.amountTypeId == amountTypeId).toList());
}

// データベースから全ての金額を一度だけ取得する。
Future<List<Wallet>> getAllWallets(AppDatabase db) {
  return db.select(db.wallets).get();
}

Future<List<Wallet>> getAllWalletsByAmountTypeId(
    AppDatabase db, int amountTypeId) {
  return db.select(db.wallets).get().then((wallets) =>
      wallets.where((wallet) => wallet.amountTypeId == amountTypeId).toList());
}

// 新しい購入履歴をデータベースに挿入する。
// Future insertWallet(AppDatabase db, Wallet wallet) {
//   return db.into(db.wallets).insert(wallet);
// }
Future insertWallet(AppDatabase db, int amount, int amountTypeId) async {
  await db.into(db.wallets).insert(
        WalletsCompanion(
          amount: Value(amount),
          amountTypeId: Value(amountTypeId),
        ),
      );
}

/// メモを更新する
Future updateWallet(AppDatabase db, Wallet wallet) {
  return db.update(db.wallets).replace(wallet);
}

// データベースからメモを削除する。
Future deleteWallet(AppDatabase db, Wallet wallet) {
  return db.delete(db.wallets).delete(wallet);
}

// アプリのドキュメントディレクトリにデータベースファイルを生成し、接続する。
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'wallet.sqlite'));
    return NativeDatabase(file);
  });
}

Future createAmountType(AppDatabase db, String title) {
  return db.into(db.amountTypes).insert(
        AmountTypesCompanion.insert(title: title),
      );
}
