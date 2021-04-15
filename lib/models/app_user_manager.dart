import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:proyectos_abitalia/helpers/firebase_errors.dart';
import 'package:proyectos_abitalia/models/app_user.dart';

class AppUserManager extends ChangeNotifier{

  AppUserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AppUser user;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool get isLogedIn => user != null;

  Future<void> signIn({AppUser user, Function onFail, Function onSuccess}) async{
    loading = true;

    try{
      final UserCredential result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
      loading = false;

    } on FirebaseAuthException catch(e){
      onFail(getErrorString(e.code));
      loading = false;
    }
  }

  Future<void> signUp({AppUser user, Function onFail, Function onSuccess}) async{
    loading = true;
    try{
      final UserCredential result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

      loading = false;
      onSuccess();
    } on PlatformException catch(e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async{
    final User currentUser = firebaseUser ?? auth.currentUser;
    if(currentUser != null){
      final DocumentSnapshot docUser = await firestore.collection('users')
          .doc(currentUser.uid).get();
      user = AppUser.fromDocument(docUser);

      final doc = await firestore.collection('admins').doc(user.id).get();
      if(doc.exists){
        final DocumentSnapshot docAdmin = await firestore.collection('admins')
            .doc(user.id).get();
        user.admin = docAdmin.data()['admin'] as bool;
        user.adminHome = docAdmin.data()['home'] as bool;
        user.adminProducts = docAdmin.data()['products'] as bool;
        user.adminOrders = docAdmin.data()['orders'] as bool;
        user.adminUsers = docAdmin.data()['users'] as bool;
      }
      notifyListeners();
    }
  }

  bool get isAdmin => user != null && user.admin;
  bool get adminUsers => user != null && user.adminUsers;
  bool get adminProducts => user != null && user.adminProducts;
  bool get adminOrders => user != null && user.adminOrders;
  bool get adminHome => user != null && user.adminHome;
}