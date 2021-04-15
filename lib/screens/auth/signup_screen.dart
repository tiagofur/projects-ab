import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/helpers/validators.dart';
import 'package:proyectos_abitalia/models/app_user.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';
import 'package:proyectos_abitalia/common/authentication/auth_presentation_web.dart';
import 'package:proyectos_abitalia/common/authentication/auth_custom_app_bar.dart';

class SignUpScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final AppUser user = AppUser();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: AuthCustomAppBar(screenSize: screenSize, buttonText: 'Entrar', navigatePage: 'login',),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5.0,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AuthPresentationWeb(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                    child: Form(
                      key: formKey,
                      child: Consumer<AppUserManager>(
                          builder: (_, userManager, child){
                            return Center(
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                shrinkWrap: true,
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.account_box_outlined),
                                      hintText: 'Inserte su Nombre Completo',
                                      labelText: 'Nombre',
                                    ),
                                    enabled: !userManager.loading,
                                    validator: (name){
                                      if(name.isEmpty){
                                        return 'Campo obligatorio';
                                      } else if(name.trim().split(' ').length <= 1){
                                        return 'Inserte su Nombre Completo';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (name) => user.name = name,
                                  ),
                                  const SizedBox(height: 16,),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.email),
                                      hintText: 'Inserte su email',
                                      labelText: 'Email',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: !userManager.loading,
                                    validator: (email){
                                      if(email.isEmpty){
                                        return 'Campo obrigatório';
                                      }
                                      else if(!emailValid(email)){
                                        return 'E-mail inválido';
                                      } else{
                                        return null;
                                      }
                                    },
                                    onSaved: (email) => user.email = email,
                                  ),
                                  const SizedBox(height: 16,),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      hintText: 'Inserte su contraseña',
                                      labelText: 'Contraseña',
                                    ),
                                    obscureText: true,
                                    enabled: !userManager.loading,
                                    validator: (pass){
                                      if(pass.isEmpty){
                                        return 'Campo obrigatório';
                                      } else if(pass.length < 6){
                                        return 'Senha muito curta';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (pass) => user.password = pass,
                                  ),
                                  const SizedBox(height: 16,),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      hintText: 'Repita su contraseña',
                                      labelText: 'Repetir Contraseña',
                                    ),
                                    obscureText: true,
                                    enabled: !userManager.loading,
                                    validator: (pass){
                                      if(pass.isEmpty){
                                        return 'Campo obrigatório';
                                      } else if(pass.length < 6){
                                        return 'Senha muito curta';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (pass) => user.confirmPassword = pass,
                                  ),
                                  const SizedBox(height: 16,),
                                  RaisedButton(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    color: Theme.of(context).primaryColor,
                                    disabledColor: Theme.of(context).primaryColor
                                        .withAlpha(100),
                                    textColor: Colors.white,
                                    onPressed: userManager.loading ? null : (){
                                      if(formKey.currentState.validate()){
                                        formKey.currentState.save();

                                        if(user.password != user.confirmPassword){
                                          scaffoldKey.currentState.showSnackBar(
                                              const SnackBar(
                                                content: Text('Senhas não coincidem!'),
                                                backgroundColor: Colors.red,
                                              )
                                          );
                                          return;
                                        }

                                        userManager.signUp(
                                            user: user,
                                            onSuccess: (){
                                              Navigator.of(context).pop();
                                            },
                                            onFail: (e){
                                              scaffoldKey.currentState.showSnackBar(
                                                  SnackBar(
                                                    content: Text('Falha ao cadastrar: $e'),
                                                    backgroundColor: Colors.red,
                                                  )
                                              );
                                            }
                                        );
                                      }
                                    },
                                    child: userManager.loading ?
                                    const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    )
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(Icons.email),
                                        const SizedBox(width: 16, height: 40,),
                                        const Text('Registrar con Email',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
