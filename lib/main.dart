import 'package:flutter/material.dart';
import 'package:toy_store/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toy Store',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
