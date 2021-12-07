import 'package:flutter/material.dart';

import 'main_page.dart';

void main() {
  runApp(const BombCryptoSimulatorApp());
}

class BombCryptoSimulatorApp extends StatelessWidget {
  const BombCryptoSimulatorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BombCrypto Simulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
