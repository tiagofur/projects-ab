import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/common/custom_drawer/custom_drawer.dart';
import 'package:proyectos_abitalia/models/client_manager.dart';
import 'package:proyectos_abitalia/screens/clients/components/card_client_mobile.dart';
import 'package:proyectos_abitalia/screens/clients/components/card_client_web.dart';
import 'package:proyectos_abitalia/screens/clients/components/create_floatbutton.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
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
          Container(
            child: Consumer<ClientManager>(builder: (_, clientManager, __) {
              final filteredProjects = clientManager.filteredClients;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: ListView.builder(
                      itemCount: filteredProjects.length,
                      itemBuilder: (_, index) {
                        if (screenSize.width < 768)
                          return CardClientMobile(filteredProjects[index]);
                        else
                          return CardClientWeb(filteredProjects[index]);
                      }),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: CreateClientFloatButton(),
    );
  }
}
