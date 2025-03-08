import 'package:flutter/material.dart';
import 'package:hackathon_vol13/pages/home/add_tab_page.dart';
import 'package:hackathon_vol13/pages/home/wallet.dart';
import 'package:hackathon_vol13/database/wallet.dart';
import 'package:hackathon_vol13/utils/parser.dart';

class AmountIcon {
  final int amountTypeImageId;
  final IconData amountTypeIconName;
  const AmountIcon(
      {required this.amountTypeImageId, required this.amountTypeIconName});
}

class HomePage extends StatefulWidget {
  final AppDatabase database;
  const HomePage({super.key, required this.database});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _tabLength = 5;
  List<AmountIcon> amountIcons = [
    const AmountIcon(amountTypeImageId: 1, amountTypeIconName: Icons.wallet),
    const AmountIcon(
        amountTypeImageId: 2, amountTypeIconName: Icons.savings_outlined),
    const AmountIcon(
        amountTypeImageId: 3, amountTypeIconName: Icons.credit_card),
    const AmountIcon(
        amountTypeImageId: 4, amountTypeIconName: Icons.attach_money),
    const AmountIcon(
        amountTypeImageId: 5, amountTypeIconName: Icons.account_balance_wallet),
    const AmountIcon(amountTypeImageId: 6, amountTypeIconName: Icons.money),
    const AmountIcon(amountTypeImageId: 7, amountTypeIconName: Icons.euro),
    const AmountIcon(
        amountTypeImageId: 8, amountTypeIconName: Icons.currency_exchange),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLength, vsync: this);
    _loadAmountTypes();
  }

  Future<void> _loadAmountTypes() async {
    final amountTypes = await getAllAmountTypes(widget.database);
    if (!mounted) return;

    setState(() {
      _tabLength = amountTypes.length + 2; // デフォルトの2つのタブを追加
      _tabController.dispose();
      _tabController = TabController(length: _tabLength, vsync: this);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            const Tab(icon: Icon(Icons.home)),
            ...List.generate(
              _tabLength - 2,
              (index) => Tab(icon: Icon(amountIcons[index].amountTypeIconName)),
            ),
            const Tab(icon: Icon(Icons.add_rounded)),
          ],
        ),
      ),
      drawerScrimColor: const Color.fromARGB(219, 89, 0, 255),
      body: TabBarView(
        controller: _tabController,
        children: [
          WalletPage(database: widget.database, tabIndex: -1),
          ...List.generate(
            _tabLength - 2,
            (index) => WalletPage(
              database: widget.database,
              tabIndex: index,
            ),
          ),
          AddTabPage(
            database: widget.database,
          ),
        ],
      ),
    );
  }
}
