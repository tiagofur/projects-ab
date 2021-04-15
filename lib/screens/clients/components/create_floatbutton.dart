import 'package:flutter/material.dart';

class CreateClientFloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    onPressed: () {
    Navigator.of(context).pushNamed('/createClient');
    },
    child: const Icon(Icons.add),
    backgroundColor: Colors.green,
    );
  }
}