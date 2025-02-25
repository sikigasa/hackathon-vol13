import 'package:flutter/material.dart';
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
  int _tabLength = 4;
  List<AmountIcon> amountIcons = [
    const AmountIcon(amountTypeImageId: 1, amountTypeIconName: Icons.wallet),
    const AmountIcon(
        amountTypeImageId: 2, amountTypeIconName: Icons.savings_outlined),
    const AmountIcon(
        amountTypeImageId: 3, amountTypeIconName: Icons.credit_card),
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
      _tabLength = amountTypes.length + 1; // デフォルトの1つのタブを追加
      _tabController.dispose(); // 古いコントローラを破棄
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
        title: const Text('資金管理'),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            // const Tab(icon: Icon(Icons.wallet)),
            // const Tab(icon: Icon(Icons.savings_outlined)),
            // const Tab(icon: Icon(Icons.credit_card)),
            ...List.generate(
              _tabLength - 1,
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
          ...List.generate(
            _tabLength - 1,
            (index) => WalletPage(
              database: widget.database,
              tabIndex: index,
            ),
          ),
          // WalletPage(
          //   database: widget.database,
          //   tabIndex: _tabLength - 4,
          // ),
          // WalletPage(
          //   database: widget.database,
          //   tabIndex: _tabLength - 3,
          // ),
          // WalletPage(
          //   database: widget.database,
          //   tabIndex: _tabLength - 2,
          // ),
          const Text("data"),
        ],
      ),
    );
  }
}
