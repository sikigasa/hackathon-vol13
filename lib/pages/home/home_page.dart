import 'package:flutter/material.dart';
import 'package:hackathon_vol13/pages/home/wallet.dart';
import 'package:hackathon_vol13/database/wallet.dart';
import 'package:hackathon_vol13/utils/parser.dart';

class HomePage extends StatefulWidget {
  final AppDatabase database;
  const HomePage({super.key, required this.database});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late int _tabLength = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4, // タブの数
      vsync: this, // 動作させるアニメーションの種類
    );
    watchAllAmountTypes(widget.database).length.then((length) {
      setState(() {
        _tabLength = length;
        _tabController = TabController(
          length: _tabLength, // タブの数
          vsync: this, // 動作させるアニメーションの種類
        );
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // 使い終わったら破棄する
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('資金管理'),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.wallet),
            ),
            Tab(
              icon: Icon(Icons.savings_outlined),
            ),
            Tab(
              icon: Icon(Icons.credit_card),
            ),
            Tab(
              icon: Icon(Icons.add_rounded),
            ),
          ],
        ),
      ),
      drawerScrimColor: const Color.fromARGB(219, 89, 0, 255),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ...List.generate(
              _tabLength,
              (index) => WalletPage(
                    database: widget.database,
                  )),
          WalletPage(
            database: widget.database,
          ),
          Center(
            child: Text(simpleParser("1, 000円 \n 500円 \n 100円")),
          ),
          WalletPage(
            database: widget.database,
          ),
          const Text("data"),
        ],
      ),
    );
  }
}
