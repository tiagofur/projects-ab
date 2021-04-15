import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/client.dart';
import 'package:proyectos_abitalia/models/client_manager.dart';

class CreateClientScreen extends StatefulWidget {
  @override
  _CreateClientScreenState createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends State<CreateClientScreen> {
  final Client client = Client();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crear Cliente'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
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
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: client.nombreTienda,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Nombre de la Tienda',
                            labelText: 'Nombre Tienda:',
                          ),
                          validator: (nombreTienda) {
                            if (nombreTienda.length < 6) {
                              return 'Nombre invalido';
                            }
                            return null;
                          },
                          onSaved: (nombreTienda) =>
                              client.nombreTienda = nombreTienda,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: client.prefijo,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Prefijo de la Tienda',
                            labelText: 'Prefijo Tienda:',
                          ),
                          validator: (prefijo) {
                            if (prefijo.length < 2) {
                              return 'Prefijo invalido';
                            }
                            return null;
                          },
                          onSaved: (prefijo) =>
                          client.prefijo = prefijo,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: client.nombreContacto,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Nombre del Contacto',
                            labelText: 'Nombre Contacto',
                          ),
                          validator: (nombreContacto) {
                            if (nombreContacto.length < 6) {
                              return 'Nombre invalido';
                            }
                            return null;
                          },
                          onSaved: (nombreContacto) =>
                              client.nombreContacto = nombreContacto,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: client.telefono,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Numero del Telefono',
                            labelText: 'Telefono',
                          ),
                          validator: (telefono) {
                            if (telefono.length < 10) {
                              return 'Telefono invalido';
                            }
                            return null;
                          },
                          onSaved: (telefono) => client.telefono = telefono,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: client.email,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.account_circle_outlined),
                            hintText: 'Email del Cliente',
                            labelText: 'Email',
                          ),
                          validator: (email) {
                            if (email.length < 6) {
                              return 'Email invalido';
                            }
                            return null;
                          },
                          onSaved: (email) => client.email = email,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: client.direccion,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.account_circle_outlined),
                            hintText: 'Direccion del Cliente',
                            labelText: 'Direccion',
                          ),
                          validator: (direccion) {
                            if (direccion.length < 6) {
                              return 'Direccion invalida';
                            }
                            return null;
                          },
                          onSaved: (direccion) => client.direccion = direccion,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Consumer<Client>(
                        builder: (_, client, __) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RaisedButton(
                                  onPressed: !client.loading
                                      ? () async {
                                          if (formKey.currentState.validate()) {
                                            formKey.currentState.save();

                                            await client.save();

                                            context
                                                .read<ClientManager>()
                                                .update(client);

                                            Navigator.of(context).pop();
                                            //Navigator.of(context).pushNamed('/clients');
                                          }
                                        }
                                      : null,
                                  textColor: Colors.white,
                                  color: primaryColor,
                                  disabledColor: primaryColor.withAlpha(100),
                                  child: client.loading
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        )
                                      : const Text(
                                          'Guardar',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
