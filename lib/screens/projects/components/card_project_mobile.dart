import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/project.dart';
import 'package:proyectos_abitalia/screens/projects/components/proccess_indicator.dart';
import 'package:proyectos_abitalia/screens/projects/components/txt_project_label.dart';

class CardProjectMobile extends StatelessWidget {
  CardProjectMobile(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: project,
      child: Card(
        child: Padding(
          padding:
              EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
          child: ExpansionTile(
            title: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TxtProjectLabel(
                      txtLabel: 'Codigo:',
                      txtString: project.numero,
                    ),
                    TxtProjectLabel(
                      txtLabel: 'Cliente:',
                      txtString: project.cliente,
                    ),
                    //TxtProjectLabel(txtLabel:'Cliente:', txtString: project.clientName,),
                    TxtProjectLabel(
                      txtLabel: '60 Dias:',
                      txtDateTime: project.previsto.toDate(),
                    ),
                  ],
                ),
                ProccessIndicator(project),
                Divider(),
              ],
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Nombre:',
                    txtString: project.nombre,
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Deseñador:',
                    txtString: project.disenador,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Firma:',
                    txtDateTime: project.firma.toDate(),
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Anticipo:',
                    txtDateTime: project.anticipo.toDate(),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Comercial:',
                    txtDateTime: project.comercial.toDate(),
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Demora Envio:',
                    txtString: project.demoraEnvio.toString(),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Produccion:',
                    txtDateTime: project.produccion.toDate(),
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Apalabrada:',
                    txtDateTime: project.apalabrada.toDate(),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Inicio Corte:',
                    txtDateTime: project.inicioCorte.toDate(),
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Modulos:',
                    txtString: project.modulos.toString(),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Interiores:',
                    txtDateTime: project.interiores.toDate(),
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Frentes:',
                    txtDateTime: project.frentes.toDate(),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(
                    txtLabel: 'Herrajes:',
                    txtDateTime: project.herrajes.toDate(),
                  ),
                  TxtProjectLabel(
                    txtLabel: 'Armador:',
                    txtString: project.armador,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
