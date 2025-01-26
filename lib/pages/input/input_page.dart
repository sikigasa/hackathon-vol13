import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_vol13/pages/cameras/camera_page.dart';
import 'package:hackathon_vol13/database/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakePictureScreen extends StatefulWidget {
  final AppDatabase database;
  const TakePictureScreen({super.key, required this.database});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  String? price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('金額入力')),
      floatingActionButton: FutureBuilder<String?>(
        future: SharedPreferences.getInstance().then((prefs) {
          return prefs.getString('GEMINI_API_KEY');
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return FloatingActionButton(
              onPressed: () async {
                price = await Navigator.push(
                  context,
                  MaterialPageRoute<String>(
                    builder: (context) => const CameraPage(),
                  ),
                );
                if (price != null) {
                  print('Received Price: $price');
                }
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.camera_alt_outlined),
            );
          }
        },
      ),
      body: InputForm(price: price, database: widget.database),
    );
  }
}

class InputForm extends StatefulWidget {
  final String? price;
  final AppDatabase database;
  const InputForm({super.key, this.price, required this.database});
  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final dateEditingController = TextEditingController(
      text:
          '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}');
  final amountEditingController = TextEditingController(text: '');

  int _amount = 0;
  List<bool> isPayment = [true, false];
  String? selectedDropdownValue; // 選択された値を保持
  Map<String, int> amountTypesMap = {};

  Future _getDate(BuildContext context) async {
    final initialDate = DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );

    if (newDate != null) {
      dateEditingController.text =
          '${newDate.year}/${newDate.month}/${newDate.day}';
    }
  }

  @override
  void dispose() {
    dateEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<String>> getAmountTypes() async {
    //   final items =
    //       await widget.database.select(widget.database.amountTypes).get();
    //   List<String> itemNames = items
    //       .map((amount) => amount.title.toString()) // 文字列に変換
    //       .toList();
    //   print("priceType: $itemNames");
    //   return itemNames;
    // }
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getDate(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date';
                    }
                    return null;
                  },
                  controller: dateEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter date',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Toggleボタン
            ToggleButtons(
              isSelected: isPayment,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isPayment.length; i++) {
                    isPayment[i] = i == index;
                  }
                });
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('支出'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('収入'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ドロップダウン
            FutureBuilder<List<String>>(
              future: getAllAmountTypes(widget.database).then((amountTypes) {
                amountTypesMap = {
                  for (var amount in amountTypes)
                    amount.title.toString(): amount.amountTypeId
                };
                return amountTypes
                    .map((amount) => amount.title.toString())
                    .toList();
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DropdownButtonFormField(
                    items: [
                      if (selectedDropdownValue != null)
                        DropdownMenuItem(
                          value: selectedDropdownValue!,
                          child: Text(selectedDropdownValue!),
                        ),
                      const DropdownMenuItem(
                        value: 'dummy',
                        child: Text('dummy'),
                      ),
                    ],
                    onChanged: (value) {},
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 初回の初期化処理
                  if (selectedDropdownValue == null &&
                      snapshot.data!.isNotEmpty) {
                    selectedDropdownValue = snapshot.data!.first;
                  }
                  return DropdownButtonFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter item',
                    ),
                    value: selectedDropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDropdownValue = newValue;
                      });
                    },
                    items: snapshot.data!.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 20),

            // 金額入力
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: amountEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter price',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some price';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                } else if (int.parse(value) <= 0) {
                  return 'Please enter a number greater than 0';
                }
                return null;
              },
              onChanged: (price) {
                if (int.tryParse(price) != null) {
                  _amount = int.parse(price);
                } else {
                  _amount = 0;
                }
              },
            ),
            const SizedBox(height: 20),

            // ボタンによる金額の変更
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _amount += 100;
                      amountEditingController.text = _amount.toString();
                    });
                  },
                  child: const Text('+100'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _amount += 500;
                      amountEditingController.text = _amount.toString();
                    });
                  },
                  child: const Text('+500'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _amount = 0;
                      amountEditingController.text = "";
                    });
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 送信ボタン
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  insertWallet(
                    widget.database,
                    isPayment[0] ? -_amount : _amount,
                    amountTypesMap[selectedDropdownValue ?? ''] ?? 0,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
