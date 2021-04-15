import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectos_abitalia/models/address.dart';

class AppUser{

  AppUser({this.id, this.name, this.email, this.password});

  AppUser.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    email = document.data()['email'] as String;
    if(document.data().containsKey('address'))
      {
        address = Address.fromMap(
            document.data()['address'] as Map<String, dynamic>);
      }
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  bool admin = false;
  bool adminHome = false;
  bool adminUsers = false;
  bool adminOrders = false;
  bool adminProducts = false;

  Address address;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  DocumentReference get firestorePermission =>
      FirebaseFirestore.instance.doc('admin/$id');
  
  CollectionReference get cartReference =>
    firestoreRef.collection('cart');

  Future<void> saveData() async{
    await firestoreRef.set(toMap());
  }

  Future<void> savePermissions() async{
    await firestorePermission.set(toMapPermissions());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      if(address != null)
        'address': address.toMap(),
    };
  }

  Map<String, bool> toMapPermissions(){
    return{
      'admin': admin,
      'home': adminHome,
      'users': adminUsers,
      'products': adminProducts,
      'orders': adminOrders
    };
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, confirmPassword: $confirmPassword, admin: $admin, adminHome: $adminHome, adminUsers: $adminUsers, adminOrders: $adminOrders, adminProducts: $adminProducts}';
  }
}