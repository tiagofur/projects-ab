import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/client.dart';
import 'package:proyectos_abitalia/screens/clients/components/txt_client_label.dart';

class CardClientWeb extends StatelessWidget {
  CardClientWeb(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: client,
      child: Card(
        child: Padding(
          padding:
              EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 6),
          child: ExpansionTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TxtClientLabel(txtLabel:'Nombre:', txtString: client.nombreTienda,),
                    TxtClientLabel(txtLabel:'Telefono:', txtString: client.telefono,),
                    TxtClientLabel(txtLabel:'Email:', txtString: client.email,),
                  ],
                ),
                Divider(),
              ],
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtClientLabel(txtLabel:'Contacto:', txtString: client.nombreContacto,),
                  TxtClientLabel(txtLabel:'Direccion:', txtString: client.direccion,),
                  TxtClientLabel(txtLabel:'Prefijo:', txtString: client.prefijo,),
                ],
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
