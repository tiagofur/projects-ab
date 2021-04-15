import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/project.dart';
import 'package:proyectos_abitalia/screens/projects/components/proccess_indicator.dart';
import 'package:proyectos_abitalia/screens/projects/components/txt_project_label.dart';

class CardProjectWeb extends StatelessWidget {
  CardProjectWeb(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: project,
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
                    TxtProjectLabel(txtLabel:'Codigo:', txtString: project.numero,),
                    TxtProjectLabel(txtLabel:'Nombre:', txtString: project.nombre,),
                    TxtProjectLabel(txtLabel:'Deseñador:', txtString: project.disenador,),
                    TxtProjectLabel(txtLabel:'Cliente:', txtString: project.cliente,),
                    TxtProjectLabel(txtLabel:'60 Dias:', txtDateTime: project.previsto.toDate(),),
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
                  TxtProjectLabel(txtLabel:'Firma:', txtDateTime: project.firma.toDate(),),
                  TxtProjectLabel(txtLabel:'Anticipo:', txtDateTime: project.anticipo.toDate(),),
                  TxtProjectLabel(txtLabel:'Coercial:', txtDateTime: project.comercial.toDate(),),
                  TxtProjectLabel(txtLabel:'Produccion:', txtDateTime: project.produccion.toDate(),),
                  TxtProjectLabel(txtLabel:'Apalabrada:', txtDateTime: project.apalabrada.toDate(),),
                  TxtProjectLabel(txtLabel:'Demora Envio:', txtString: project.demoraEnvio.toString(),),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxtProjectLabel(txtLabel:'Inicio Corte:', txtDateTime: project.inicioCorte.toDate(),),
                  TxtProjectLabel(txtLabel:'Modulos:', txtString: project.modulos.toString(),),
                  TxtProjectLabel(txtLabel:'Interiores:', txtDateTime: project.interiores.toDate(),),
                  TxtProjectLabel(txtLabel:'Frentes:', txtDateTime: project.frentes.toDate(),),
                  TxtProjectLabel(txtLabel:'Herrajes:', txtDateTime: project.herrajes.toDate(),),
                  TxtProjectLabel(txtLabel:'Armador:', txtString: project.armador,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
