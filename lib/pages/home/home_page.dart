import 'package:flutter/material.dart';
import 'package:hackathon_vol13/pages/home/wallet.dart';
import 'package:hackathon_vol13/database/wallet.dart';

class HomePage extends StatefulWidget {
  final AppDatabase database;
  const HomePage({super.key, required this.database});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _tabLength = 4;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabLength, // タブの数
      vsync: this, // 動作させるアニメーションの種類
    );
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
          WalletPage(
            database: widget.database,
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
          Text("data"),
        ],
      ),
    );
  }
}
