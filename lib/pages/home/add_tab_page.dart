import 'package:flutter/material.dart';
import 'package:hackathon_vol13/database/wallet.dart';

class AddTabPage extends StatefulWidget {
  final AppDatabase database;
  AddTabPage({super.key, required this.database});

  @override
  State<AddTabPage> createState() => _AddTabPageState();
}

class _AddTabPageState extends State<AddTabPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  List<bool> isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "タブを追加する",
              textAlign: TextAlign.left,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'タブ名',
              ),
              onChanged: (value) {
                title = value;
              },
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                isSelected: isSelected,
                borderRadius: BorderRadius.circular(8.0),
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                children: const [
                  Icon(Icons.wallet),
                  Icon(Icons.savings_outlined),
                  Icon(Icons.credit_card),
                  Icon(Icons.attach_money),
                  Icon(Icons.account_balance_wallet),
                  Icon(Icons.money),
                  Icon(Icons.euro),
                  Icon(Icons.currency_exchange),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  int index = isSelected.indexWhere((element) => element);
                  createAmountType(widget.database, title, index + 1);
                  Navigator.pop(context);
                }
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
