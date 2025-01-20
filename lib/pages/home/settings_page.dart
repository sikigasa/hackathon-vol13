import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Key管理'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                controller: TextEditingController(
                    text: prefs?.getString('GEMINI_API_KEY') ?? ''),
                decoration: const InputDecoration(
                  labelText: 'geminiAPI Key',
                  hintText: 'API Key',
                ),
                onChanged: (value) {
                  prefs?.setString('GEMINI_API_KEY', value);
                },
                onSaved: (value) {
                  prefs?.setString('GEMINI_API_KEY', value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
