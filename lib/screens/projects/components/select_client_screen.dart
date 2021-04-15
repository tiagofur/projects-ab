import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/client_manager.dart';
import 'package:proyectos_abitalia/screens/projects/components/search_dialog.dart';
import 'package:proyectos_abitalia/screens/projects/components/selecte_client_card.dart';

class SelectClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ClientManager>(
          builder: (_, clientManager, __) {
            if (clientManager.search.isEmpty) {
              return const Text('Selecionar Cliente');
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(clientManager.search));
                    if (search != null) {
                      context.read<ClientManager>().search = search;
                    }
                  },
                  child: Container(
                    width: constraints.biggest.width,
                    child: Text(
                      clientManager.search,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              });
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ClientManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      context.read<ClientManager>().search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    context.read<ClientManager>().search = '';
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Consumer<ClientManager>(builder: (_, clientManager, __) {
          final filteredProjects = clientManager.filteredClients;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: ListView.builder(
                  itemCount: filteredProjects.length,
                  itemBuilder: (_, index) {
                    if (screenSize.width < 768)
                      return CardSelectClient(filteredProjects[index]);
                    else
                      return CardSelectClient(filteredProjects[index]);
                  }),
            ),
          );
        }),
      ),
    );
  }
}
