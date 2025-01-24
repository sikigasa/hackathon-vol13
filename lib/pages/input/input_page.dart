import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_vol13/pages/cameras/camera_page.dart';
import 'package:hackathon_vol13/database/wallet.dart';

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
      appBar: AppBar(title: const Text('input')),
      floatingActionButton: FloatingActionButton(
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
  final amountEditingController = TextEditingController(text: '0');
  Future _getDate(BuildContext context) async {
    final initialDate = DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );

    if (newDate != null) {
      //選択した日付をTextFormFieldに設定
      dateEditingController.text =
          '${newDate.year}/${newDate.month}/${newDate.day}';
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    // _setup();
  }

  @override
  void dispose() {
    dateEditingController.dispose();
    super.dispose();
  }

  int _amount = 0;
  List<bool> isSelected = [true, false];
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

    var dropDownText = "EnterWallet";
    Map<String, int> amountTypesMap = {};

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            // set DateTime
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
                    final dateParts = value.split('/');
                    if (dateParts.length != 3) {
                      return 'Please enter a valid date in yyyy/mm/dd format';
                    }
                    final year = int.tryParse(dateParts[0]);
                    final month = int.tryParse(dateParts[1]);
                    final day = int.tryParse(dateParts[2]);
                    if (year == null || month == null || day == null) {
                      return 'Please enter a valid date in yyyy/mm/dd format';
                    }
                    if (month < 1 || month > 12 || day < 1 || day > 31) {
                      return 'Please enter a valid date in yyyy/mm/dd format';
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
            const SizedBox(
              height: 20,
            ),
            ToggleButtons(
              isSelected: isSelected,
              onPressed: (int index) {
                setState(() {
                  // 押されたボタンだけがtrueになるように設定
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('支出'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('収入'),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
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
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return DropdownButtonFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter item',
                        ),
                        value: snapshot.data!.first,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownText = newValue!;
                          });
                        },
                        items: snapshot.data!.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
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
                  amountEditingController.text = _amount.toString();
                }
              },
            ),
            const SizedBox(height: 20),
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
                  onPressed: () {},
                  child: const Text('+500'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    insertWallet(widget.database, _amount,
                        amountTypesMap[dropDownText] ?? 0);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
