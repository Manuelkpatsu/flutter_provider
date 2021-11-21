import 'package:flutter/material.dart';
import 'package:flutterprovider/services/service_locator.dart';
import 'package:flutterprovider/ui/views/calculate_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XChange',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const CalculateCurrencyScreen(),
    );
  }
}
