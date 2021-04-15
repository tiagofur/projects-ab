import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyectos_abitalia/models/client.dart';
import 'package:proyectos_abitalia/models/client_manager.dart';

enum Status { cancelado, venta , ingenieria, produccion, empaque, almacen, entregado}

class Project extends ChangeNotifier {

    Project({
        this.id,
        this.nombre,
        this.numero,
        this.disenador,
        this.cliente,
        //this.contacto,
        this.firma,
        this.anticipo,
        this.comercial,
        this.previsto,
        this.produccion,
        this.apalabrada,
        this.demoraEnvio,
        this.inicioCorte,
        this.modulos,
        this.interiores,
        this.frentes,
        this.herrajes,
        this.armador,
        this.status = Status.venta,
        this.proccess,
        this.clientInfo,
    });

    Project.fromDocument(DocumentSnapshot document) {
        id = document.id;
        nombre = document.data()['nombre'] as String;
        numero = document.data()['numero'] as String;
        disenador = document.data()['disenador'] as String;
        cliente = document.data()['cliente'] as String;
        //contacto = document.data()['contacto'] as String;
        firma = (document.data()['firma'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        anticipo = (document.data()['anticipo'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        comercial = (document.data()['comercial'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        previsto = (document.data()['previsto'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        produccion = (document.data()['produccion'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        apalabrada = (document.data()['apalabrada'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        demoraEnvio = (document.data()['demora_envio'] ?? 999) as int;
        inicioCorte = (document.data()['inicio_corte'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        modulos = (document.data()['modulos'] ?? 999) as int;
        interiores = (document.data()['interiores'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        frentes = (document.data()['frentes'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        herrajes = (document.data()['herrajes'] ?? Timestamp.fromMicrosecondsSinceEpoch(0)) as Timestamp;
        armador = (document.data()['armador'] ?? '') as String;
        status = Status.values[document.data()['status'] as int];
        proccess = (document.data()['proceso'] ?? [0,0,0,0,0,0,0,0,0,0,0]);
        clientInfo = findClientById(cliente);
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference get firestoreRef => firestore.doc('clients/$cliente/projects/$id');
    DocumentReference get fireClientRef => firestore.doc('clients/$cliente');

    ClientManager clientManager = ClientManager();

    findClientById(String id) {
        try {
            var cliente = clientManager.allClients.firstWhere((p) => p.id == id);
            print(cliente.nombreTienda);
            return cliente;
        } catch (e){
            return null;
        }
    }

    String id;
    String nombre;
    String numero;
    String disenador;
    String cliente;
    //String contacto;
    Timestamp firma;
    Timestamp anticipo;
    Timestamp comercial;
    Timestamp previsto;
    Timestamp produccion;
    Timestamp apalabrada;
    int demoraEnvio;
    Timestamp inicioCorte;
    int modulos;
    Timestamp interiores;
    Timestamp frentes;
    Timestamp herrajes;
    String armador;
    Status status;
    List proccess;
    Client clientInfo;

    bool _loading = false;
    bool get loading => _loading;
    set loading(bool value){
        _loading = value;
        notifyListeners();
    }

    Future<void> save() async {
        loading = true;

        final Map<String, dynamic> data = {
            'nombre': nombre,
            'numero': numero,
            'disenador': disenador,
            'cliente': cliente,
            //'contacto': contacto,
            'firma': firma,
            'anticipo': anticipo,
            'comercial': comercial,
            'previsto': previsto,
            'apalabrada': apalabrada,
            'demora_envio': demoraEnvio,
            'modulos': modulos,
            'status': status,
            'proccess': [0,0,0,0,0,0,0,0,0,0,0]
        };

        if(id == null){
            final doc = await firestore.collection('clients/$cliente/projects').add(data);
            id = doc.id;
        } else {
            await firestoreRef.update(data);
        }
        loading = false;
    }

    void delete(){
        firestoreRef.update({'status': Status.cancelado});
    }

    void unDelete(){
        firestoreRef.update({'status': Status.venta});
    }

    Project clone(){
        return Project(
            id: id,
            nombre: nombre,
            numero: numero,
            disenador: disenador,
            cliente: cliente,
            //contacto: contacto,
            firma: firma,
            anticipo: anticipo,
            comercial: comercial,
            previsto: previsto,
            produccion: produccion,
            apalabrada: apalabrada,
            demoraEnvio: demoraEnvio,
            inicioCorte: inicioCorte,
            modulos: modulos,
            interiores: interiores,
            frentes: frentes,
            herrajes: herrajes,
            armador: armador,
            status: status,
            proccess: proccess,
        );
    }
}