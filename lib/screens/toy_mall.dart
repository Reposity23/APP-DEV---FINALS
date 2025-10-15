import 'package:flutter/material.dart';

class ToyMallScreen extends StatelessWidget {
  const ToyMallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToyMall'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text('Welcome to ToyMall!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
