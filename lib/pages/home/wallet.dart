import 'package:flutter/material.dart';
import 'package:hackathon_vol13/database/wallet.dart';

class WalletPage extends StatefulWidget {
  final AppDatabase database;
  final int tabIndex;
  const WalletPage({super.key, required this.database, required this.tabIndex});

  @override
  State<WalletPage> createState() => _WalletPageState();
  // // 戻ってきたときにdbからデータを取得する
  // State<WalletPage> setState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('残高', style: TextStyle(fontSize: 15)),
          WalletCard(
            database: widget.database,
            tabIndex: widget.tabIndex,
          ),
        ],
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  final AppDatabase database;
  final int tabIndex;
  const WalletCard({super.key, required this.database, required this.tabIndex});
  @override
  Widget build(BuildContext context) {
    // database
    // .into(database.amountTypes)
    // .insert(AmountType(amountTypeId: 0, title: "wallet"));
    // insertWallet(database, Wallet(walletId: 0, amount: 1000, amountTypeId: 0));
    Future<int> getBalance() async {
      int totalAmount = -1;
      if (tabIndex == -1) {
        var balances = await getAllWallets(database);
        totalAmount = balances.fold(0, (acc, wallet) => acc + wallet.amount);
        return totalAmount;
      } else {
        var balances = await getAllWalletsByAmountTypeId(database, tabIndex);
        totalAmount = balances.fold(0, (acc, wallet) => acc + wallet.amount);
      }

      return totalAmount;
    }

    var balance = getBalance();
    return Stack(
      children: [
        Center(
          child: Card(
            color: const Color.fromARGB(255, 28, 105, 135),
            child: InkWell(
              splashColor: Colors.greenAccent.withAlpha(10),
              highlightColor: Colors.transparent,
              onTap: () {
                // タップ時の処理
              },
              child: SizedBox(
                width: 300,
                height: 180,
                child: Center(
                  child: FutureBuilder<int>(
                    // 非同期処理を行う関数を指定
                    future: balance,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // データがまだ取得されていない場合の表示
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // エラーが発生した場合の表示
                        return Text('${snapshot.error}',
                            style: const TextStyle(fontSize: 30));
                      } else {
                        // データが取得できた場合の表示
                        return Text(
                          '${snapshot.data}円',
                          style: TextStyle(
                            fontSize: 30,
                            color: snapshot.data! < 0
                                ? Colors.redAccent
                                : Colors.white,
                          ),
                        );
                      }
                    },
                  ), //Text('$balance円', style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
