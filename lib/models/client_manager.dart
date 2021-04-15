import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyectos_abitalia/models/client.dart';

class ClientManager extends ChangeNotifier{

  ClientManager(){
    _loadAllClients();
    debugPrint('Load Client Manager');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Client> allClients = [];

  String _search = '';

  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Client> get filteredClients {
    final List<Client> filteredClients = [];

    if(search.isEmpty){
      filteredClients.addAll(allClients);
    } else {
      filteredClients.addAll(
          allClients.where(
                  (p) => p.nombreTienda.toLowerCase().contains(search.toLowerCase())
          )
      );
    }
    return filteredClients;
  }

  Future<void> _loadAllClients() async {
    final snapClients = await firestore.collection('clients').where('activo', isEqualTo: true).get();
    allClients = snapClients.docs.map((d) => Client.fromDocument(d)).toList();
    notifyListeners();
  }

  Client findClientById(String id){
    try {
      return allClients.firstWhere((c) => c.id == id);
    } catch (e){
      debugPrint('Cliente no encontrado');
      return null;
    }
  }

  void update(Client client){
    allClients.removeWhere((p) => p.id == client.id);
    allClients.add(client);
    notifyListeners();
  }

  void delete(Client client){
    client.delete();
    allClients.removeWhere((p) => p.id == client.id);
    notifyListeners();
  }

  void unDelete(Client client){
    client.unDelete();
    allClients.add(client);
    notifyListeners();
  }
}