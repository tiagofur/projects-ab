import 'package:flutter/material.dart';
import 'package:proyectos_abitalia/common/custom_drawer/custom_drawer.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(128, 30, 130, 24),
                //Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(128, 199, 31, 0)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Center(
          child: Text('Account Screen'),
        ),
      ]),
    );
  }
}
