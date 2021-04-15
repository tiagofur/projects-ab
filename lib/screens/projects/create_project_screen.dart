import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:proyectos_abitalia/common/custom_drawer/custom_drawer.dart';
import 'package:proyectos_abitalia/models/project.dart';
import 'package:proyectos_abitalia/models/project_manager.dart';

class CreateProjectScreen extends StatefulWidget {
  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  var selectedClient;
  final Project project = Project();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: project,
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Crear Proyecto'),
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
                  padding: EdgeInsets.only(
                      top: 16, bottom: 16, left: 8, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),),
                    elevation: 5,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          TextFormField(
                            initialValue: project.nombre,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Nombre del Proyecto',
                              labelText: 'Nombre',
                            ),
                            validator: (nombre) {
                              if (nombre.length < 6) {
                                return 'Nombre invalido';
                              }
                              return null;
                            },
                            onSaved: (nombre) =>
                                project.nombre = nombre,
                          ),
                          TextFormField(
                            initialValue: project.numero,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Numero del Proyecto',
                              labelText: 'Numero',
                            ),
                            validator: (numero) {
                              if (numero.length < 10) {
                                return 'Numero invalido';
                              }
                              return null;
                            },
                            onSaved: (numero) =>
                                project.numero = numero,
                          ),
                          TextFormField(
                            initialValue: project.disenador,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Diseñador',
                              labelText: 'Diseñador',
                            ),
                            validator: (disenador) {
                              if (disenador.length < 5) {
                                return 'Disenador invalido';
                              }
                              return null;
                            },
                            onSaved: (disenador) =>
                            project.disenador = disenador,
                          ),
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
                                  children: [
                                    Icon(
                                      Icons.account_circle_outlined,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: DropdownButton(
                                        items: clientsItems,
                                        onChanged: (clientsValue) {
                                          debugPrint(clientsValue);
                                          setState(() {
                                            project.cliente = clientsValue;
                                          });
                                        },
                                        value: project.cliente,
                                        isExpanded: false,
                                        hint: Text('choose a client'),

                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                                  Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha de pago',
                              labelText: 'Pago',
                            ),
                            onSaved: (pago) =>
                                project.anticipo = Timestamp.fromDate(pago),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                                  Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha de firma contrato',
                              labelText: 'Firma Contrato',
                            ),
                            onSaved: (firma) =>
                                project.firma = Timestamp.fromDate(firma),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                                  Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha de envio comercial',
                              labelText: 'Comercial',
                            ),
                            onSaved: (comercial) => project
                                .comercial = Timestamp.fromDate(comercial),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue:
                                project.demoraEnvio.toString(),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: '0',
                              labelText: 'Demora Envio',
                            ),
                            validator: (demoraEnvio) {
                              if (demoraEnvio.length < 1) {
                                return 'Demora Envio invalido';
                              }
                              return null;
                            },
                            onSaved: (demoraEnvio) => project
                                .demoraEnvio = int.parse(demoraEnvio),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                                  Icon(Icons.account_circle_outlined),
                              hintText: 'Entrega Prevista',
                              labelText: 'Previsto',
                            ),
                            onSaved: (previsto) => project.previsto =
                                Timestamp.fromDate(previsto),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                                  Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha Apalabrada',
                              labelText: 'Apalabrada',
                            ),
                            onSaved: (apalabrada) => project
                                .apalabrada = Timestamp.fromDate(apalabrada),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: project.modulos.toString(),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: '0',
                              labelText: 'Modulos',
                            ),
                            validator: (modulos) {
                              if (modulos.length < 1) {
                                return 'Demora Envio invalido';
                              }
                              return null;
                            },
                            onSaved: (modulos) =>
                                project.modulos = int.parse(modulos),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Consumer<Project>(
                            builder: (_, project, __) {
                              return Row(
                                children: [
                                  RaisedButton(
                                    onPressed: !project.loading
                                        ? () async {
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();

                                              await project.save();

                                              context
                                                  .read<ProjectManager>()
                                                  .update(project);

                                              Navigator.of(context).pop();
                                              //Navigator.of(context).pushNamed('/projects');
                                            }
                                          }
                                        : null,
                                    textColor: Colors.white,
                                    color: primaryColor,
                                    disabledColor:
                                        primaryColor.withAlpha(100),
                                    child: project.loading
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation(
                                                    Colors.white),
                                          )
                                        : const Text(
                                            'Guardar',
                                            style: TextStyle(fontSize: 18.0),
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
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Crear Proyecto'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(),
            //drawer: CustomDrawer(),
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
                  padding: EdgeInsets.only(
                      top: 32, bottom: 32, left: 32, right: 32),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),),
                    elevation: 5,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        padding: EdgeInsets.all(32),
                        children: [
                          TextFormField(
                            initialValue: project.nombre,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Nombre del Proyecto',
                              labelText: 'Nombre',
                            ),
                            validator: (nombre) {
                              if (nombre.length < 6) {
                                return 'Nombre invalido';
                              }
                              return null;
                            },
                            onSaved: (nombre) =>
                            project.nombre = nombre,
                          ),
                          TextFormField(
                            initialValue: project.numero,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Numero del Proyecto',
                              labelText: 'Numero',
                            ),
                            validator: (numero) {
                              if (numero.length < 10) {
                                return 'Numero invalido';
                              }
                              return null;
                            },
                            onSaved: (numero) =>
                            project.numero = numero,
                          ),
                          TextFormField(
                            initialValue: project.disenador,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Diseñador',
                              labelText: 'Diseñador',
                            ),
                            validator: (disenador) {
                              if (disenador.length < 5) {
                                return 'Disenador invalido';
                              }
                              return null;
                            },
                            onSaved: (disenador) =>
                            project.disenador = disenador,
                          ),
                          TextFormField(
                            initialValue: project.nombre,
                            decoration: const InputDecoration(
                              icon:
                              Icon(Icons.account_circle_outlined),
                              hintText: 'Nombre del Cliente',
                              labelText: 'Cliente',
                            ),
                            validator: (cliente) {
                              if (cliente.length < 6) {
                                return 'Cliente invalido';
                              }
                              return null;
                            },
                            onSaved: (cliente) =>
                            project.cliente = cliente,
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                              Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha de pago',
                              labelText: 'Pago',
                            ),
                            onSaved: (pago) =>
                            project.anticipo = Timestamp.fromDate(pago),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                              Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha de firma contrato',
                              labelText: 'Firma Contrato',
                            ),
                            onSaved: (firma) =>
                            project.firma = Timestamp.fromDate(firma),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                              Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha de envio comercial',
                              labelText: 'Comercial',
                            ),
                            onSaved: (comercial) => project
                                .comercial = Timestamp.fromDate(comercial),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue:
                            project.demoraEnvio.toString(),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: '0',
                              labelText: 'Demora Envio',
                            ),
                            validator: (demoraEnvio) {
                              if (demoraEnvio.length < 1) {
                                return 'Demora Envio invalido';
                              }
                              return null;
                            },
                            onSaved: (demoraEnvio) => project
                                .demoraEnvio = int.parse(demoraEnvio),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                              Icon(Icons.account_circle_outlined),
                              hintText: 'Entrega Prevista',
                              labelText: 'Previsto',
                            ),
                            onSaved: (previsto) => project.previsto =
                                Timestamp.fromDate(previsto),
                          ),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              icon:
                              Icon(Icons.account_circle_outlined),
                              hintText: 'Fecha Apalabrada',
                              labelText: 'Apalabrada',
                            ),
                            onSaved: (apalabrada) => project
                                .apalabrada = Timestamp.fromDate(apalabrada),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: project.modulos.toString(),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: '0',
                              labelText: 'Modulos',
                            ),
                            validator: (modulos) {
                              if (modulos.length < 1) {
                                return 'Demora Envio invalido';
                              }
                              return null;
                            },
                            onSaved: (modulos) =>
                            project.modulos = int.parse(modulos),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Consumer<Project>(
                            builder: (_, project, __) {
                              return Row(
                                children: [
                                  Expanded(child: Container(),),
                                  RaisedButton(
                                    onPressed: !project.loading
                                        ? () async {
                                      if (formKey.currentState
                                          .validate()) {
                                        formKey.currentState.save();

                                        await project.save();

                                        context
                                            .read<ProjectManager>()
                                            .update(project);

                                        Navigator.of(context)
                                            .pushNamed('/projects');
                                      }
                                    }
                                        : null,
                                    textColor: Colors.white,
                                    color: primaryColor,
                                    disabledColor:
                                    primaryColor.withAlpha(100),
                                    child: project.loading
                                        ? const CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation(
                                          Colors.white),
                                    )
                                        : Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                          child: const Text(
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
          );
        }
      }),
    );
  }
}
