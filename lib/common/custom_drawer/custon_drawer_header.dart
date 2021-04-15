import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';
import 'package:proyectos_abitalia/models/page_manager.dart';

// ignore: use_key_in_widget_constructors
class CustonDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 200,
      child: Consumer<AppUserManager>(
        builder: (_, userManager, __){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Image (image :AssetImage('assets/images/logo-abitalia.png')),
              ),
              SizedBox(height: 16,),
              Text(
                'Hola, ${userManager.user?.name ?? 'visitante!'}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userManager.isLogedIn ?
                  GestureDetector(
                    onTap: (){
                      context.read<PageManager>().setPage(2);
                    },
                    child: Text(
                      'Mi Perfil',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ) :
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      if(userManager.isLogedIn){
                        context.read<PageManager>().setPage(0);
                        userManager.signOut();
                      } else {
                        context.read<PageManager>().setPage(0);
                      }
                    },
                    child: Text(
                      userManager.isLogedIn ? 'Salir' : 'Entrar',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      )
    );
  }
}
