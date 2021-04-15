import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/client.dart';
import 'package:proyectos_abitalia/screens/clients/components/txt_client_label.dart';

class CardSelectClient extends StatelessWidget {

  CardSelectClient(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: client,
      child: Card(
        child: Padding(
          padding:
          EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TxtClientLabel(txtLabel:'Nombre:', txtString: client.nombreTienda,),
              TxtClientLabel(txtLabel:'Prefijo:', txtString: client.prefijo,),
            ],
          ),
        ),
      ),
    );
  }
}
