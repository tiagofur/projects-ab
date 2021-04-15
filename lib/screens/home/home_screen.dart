import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/common/custom_drawer/custom_drawer.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  var selectedType;
  var selectedClient;
  List<String> _acontType = ['Client', 'User', 'Manager', 'Administrator'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
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
          Form(
            key: _formKeyValue,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle_outlined),
                    hintText: 'Entre your name',
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.monetization_on_sharp,
                    size: 25,
                  ),
                  SizedBox(width: 50),
                  DropdownButton(
                    items: _acontType
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (selectedAccountType) {
                      setState(() {
                        selectedType = selectedAccountType;
                      });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text('Chese Account Type'),
                  ),
                ]),
                SizedBox(height: 40),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('clients')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loading');
                    } else {
                      List<DropdownMenuItem> clientsItems = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        clientsItems.add(DropdownMenuItem(
                          child: Text(
                            '${snap.data()['nombre_tienda']}',
                          ),
                          value: snap.id,
                        ));
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on_sharp,
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          DropdownButton(
                            items: clientsItems,
                            onChanged: (clientsValue) {
                              debugPrint(clientsValue);
                              setState(() {
                                selectedClient = clientsValue;
                              });
                            },
                            value: selectedClient,
                            isExpanded: false,
                            hint: Text('choose a client'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
