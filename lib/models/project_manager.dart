import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyectos_abitalia/models/client.dart';
import 'project.dart';

class ProjectManager extends ChangeNotifier{

  ProjectManager(){
    _loadAllProjects();
    debugPrint('Load Project Manager');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Client> allClients = [];
  List<Project> allProjects = [];

  String _search = '';
  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Project> get filteredProjects {
    final List<Project> filteredProjects = [];

    if(search.isEmpty){
      filteredProjects.addAll(allProjects);
    } else {
      filteredProjects.addAll(
          allProjects.where(
              (p) => p.nombre.toLowerCase().contains(search.toLowerCase())
          )
      );
    }
    return filteredProjects;
  }

  Future<void> _loadAllClients() async {
    final snapClients = await firestore.collection('clients').where('activo', isEqualTo: true).get();
    allClients = snapClients.docs.map((d) => Client.fromDocument(d)).toList();
  }

  Future<void> _loadAllProjects() async {
    await _loadAllClients();
    print(allClients[0].nombreTienda);
    allClients.forEach((client) async {
      final snapProjects = await firestore.collection('clients/${client.id}/projects/').where('status', isEqualTo: Status.produccion.index).get();
      allProjects = snapProjects.docs.map((d) => Project.fromDocument(d)).toList();
    });
    notifyListeners();
  }

  Project findProjectById(String id){
    try {
      return allProjects.firstWhere((p) => p.id == id);
    } catch (e){
      return null;
    }
  }

  Client findClientById(String id){
    try {
      return allClients.firstWhere((c) => c.id == id);
    } catch (e){
      debugPrint('Cliente no encontrado');
      return null;
    }
  }

  void update(Project project){
    allProjects.removeWhere((p) => p.id == project.id);
    allProjects.add(project);
    notifyListeners();
  }

  void delete(Project project){
    project.delete();
    allProjects.removeWhere((p) => p.id == project.id);
    notifyListeners();
  }

  void unDelete(Project project){
    project.unDelete();
    allProjects.add(project);
  }
}