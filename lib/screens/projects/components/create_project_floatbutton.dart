import 'package:flutter/material.dart';

class CreateProjectFloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    onPressed: () {
    Navigator.of(context).pushNamed('/createProject');
    },
    child: const Icon(Icons.add),
    backgroundColor: Colors.green,
    );
  }
}