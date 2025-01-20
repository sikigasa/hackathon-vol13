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
  final textEditingController = TextEditingController(
      text:
          '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}');
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
      textEditingController.text =
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
    textEditingController.dispose();
    super.dispose();
  }

  int _amount = 0;
  @override
  Widget build(BuildContext context) {
    Future<List<String>> getAmountTypes() async {
      final items =
          await widget.database.select(widget.database.amountTypes).get();
      List<String> itemNames = items
          .map((amount) => amount.title.toString()) // 文字列に変換
          .toList();
      print("priceType: $itemNames");
      return itemNames;
    }

    var amountTypes = getAmountTypes();
    var dropDownText = "Enter wallet type";

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // set DateTime
          TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter date',
            ),
            onTap: () {
              _getDate(context);
            },
            onChanged: (date) {
              print(date);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            initialValue: widget.price,
            decoration: const InputDecoration(
              hintText: 'Enter price',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some price';
              }
              return null;
            },
            onChanged: (price) {
              _amount = int.parse(price);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<List<String>>(
            future: getAllAmountTypes(widget.database).then(
              (amountTypes) =>
                  amountTypes.map((amount) => amount.title.toString()).toList(),
            ),
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
                      value: dropDownText = snapshot.data![0],
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  insertWallet(
                    widget.database,
                    _amount,
                    0,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
