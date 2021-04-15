import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Client extends ChangeNotifier {

  Client({
    this.id,
    this.nombreTienda,
    this.nombreContacto,
    this.direccion,
    this.telefono,
    this.email,
    this.prefijo,
    this.activo = true
  });

  Client.fromDocument(DocumentSnapshot document){
    id = document.id;
    nombreTienda = document.data()['nombre_tienda'] as String;
    nombreContacto = document.data()['nombre_contacto'] as String;
    direccion = document.data()['direccion'] as String;
    telefono = document.data()['telefono'] as String;
    email = document.data()['email'] as String;
    prefijo = document.data()['prefijo'] as String;
    activo = document.data()['activo'] as bool;
  }

  Client.fromMap(Map<String, dynamic> map){
    nombreTienda = map['nombre_tienda'] as String;
    nombreContacto = map['nombre_contacto'] as String;
    direccion = map['direccion'] as String;
    telefono = map['telefono'] as String;
    email = map['email'] as String;
    prefijo = map['prefijo'] as String;
    activo = map['activo'] as bool;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference get firestoreRef => firestore.doc('clients/$id');

  String id;
  String nombreTienda;
  String nombreContacto;
  String direccion;
  String telefono;
  String email;
  String prefijo;
  bool activo;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'nombre_tienda': nombreTienda,
      'nombre_contacto': nombreContacto,
      'direccion': direccion,
      'telefono': telefono,
      'email': email,
      'prefijo': prefijo,
      'activo': activo,
    };

    if(id == null){
      final doc = await firestore.collection('clients').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    loading = false;
  }

  void delete(){
    firestoreRef.update({'activo': false});
  }

  void unDelete(){
    firestoreRef.update({'activo': true});
  }

  Client clone(){
    return Client(
      id: id,
      nombreTienda: nombreTienda,
      nombreContacto: nombreContacto,
      direccion: direccion,
      telefono: telefono,
      email: email,
      prefijo: prefijo,
      activo: activo
    );
  }
}