import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';

class CustomAppBar extends StatelessWidget {
  final screenSize;

  CustomAppBar({this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUserManager>(builder: (_, userManager, __) {
      return Container(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('/home');
                },
                child: Text(
                  'ABITALIA HOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/createProject');
                      },
                      child: Text(
                        'Crear Proyecto',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Contact Us',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                userManager.user.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: screenSize.width / 50,
              ),
              InkWell(
                onTap: () {
                  userManager.signOut();
                  Navigator.of(context).pushNamed('/login');
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
