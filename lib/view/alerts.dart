import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  const Alerts({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(title),
      ),
      body: const Center(child: Column(children: [])),
    );
  }
}
