import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'wallet.g.dart';

// @DataClassName('Wallet')
class Wallets extends Table {
  IntColumn get walletId => integer().autoIncrement()();
  IntColumn get amount => integer()();
  IntColumn get amountTypeId =>
      integer().references(AmountTypes, #priceTypeId)();
}

// @DataClassName('PriceType')
class AmountTypes extends Table {
  IntColumn get priceTypeId => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
}

@DriftDatabase(tables: [Wallets, AmountTypes])
class AppDatabase extends _$AppDatabase {
  @override
  // データベースのスキーマバージョンを返す。現在は1。
  int get schemaVersion => 1;
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
  AppDatabase() : super(_openConnection());

  get walletDao => null;
}

/// データベースから全てのメモをストリームとして取得する。
/// メモが追加、更新、削除されると、このストリームは新しいリストを返す。
Stream<List<Wallet>> watchAllWallets(AppDatabase db) {
  return db.select(db.wallets).watch();
}

/// データベースから全ての金額を一度だけ取得する。
Future<List<Wallet>> getAllWallets(AppDatabase db) {
  return db.select(db.wallets).get();
}

/// 新しい購入履歴をデータベースに挿入する。
Future insertWallet(AppDatabase db, Wallet wallet) {
  return db.into(db.wallets).insert(wallet);
}

/// メモを更新する。
Future updateWallet(AppDatabase db, Wallet wallet) {
  return db.update(db.wallets).replace(wallet);
}

/// データベースからメモを削除する。
Future deleteWallet(AppDatabase db, Wallet wallet) {
  return db.delete(db.wallets).delete(wallet);
}

/// アプリのドキュメントディレクトリにデータベースファイルを生成し、接続する。
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'wallet.sqlite'));
    return NativeDatabase(file);
  });
}
