import 'package:flutter/material.dart';

class TMPPage extends StatelessWidget {
  const TMPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMP Page'),
      ),
      body: const Center(
        child: Text('Temporaty page'),
      ),
    );
  }
}