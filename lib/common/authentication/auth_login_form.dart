import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/helpers/validators.dart';
import 'package:proyectos_abitalia/models/app_user.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';
import 'package:proyectos_abitalia/models/page_manager.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();

class AuthLoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Consumer<AppUserManager>(
            builder: (_, userManager, child){
              return ListView(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: emailController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Inserte su email',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if(!emailValid(email)){
                        return 'Email no valido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Inserte su contraseña',
                      labelText: 'Contraseña',
                    ),
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty || pass.length < 6) {
                        return 'Contraseña no valida';
                      }
                      return null;
                    },
                  ),
                  //child,
                  const SizedBox(height: 16,),
                  RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(80),
                    textColor: Colors.white,
                    onPressed: userManager.loading ? null : (){
                      if(_formKey.currentState.validate()){
                        userManager.signIn(
                          user: AppUser(
                            email: emailController.text,
                            password: passController.text,
                          ),
                          onSuccess: (){
                            context.read<PageManager>().setPage(4);
                          },
                          onFail: (e){
                            debugPrint(e.toString());
                            showToast(
                              e.toString(),
                              context: context,
                              animation: StyledToastAnimation.scale,
                              reverseAnimation: StyledToastAnimation.fade,
                              position: StyledToastPosition.bottom,
                              animDuration: Duration(seconds: 1),
                              duration: Duration(seconds: 4),
                              curve: Curves.elasticOut,
                              reverseCurve: Curves.linear,
                              backgroundColor: Colors.red,
                              textStyle: TextStyle(
                                color: Colors.white,
                              )
                            );
                          },
                        );
                      }
                    },
                    child: userManager.loading ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 16, height: 40,),
                        const Text('Entrar con Email',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
