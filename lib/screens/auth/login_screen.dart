import 'package:flutter/material.dart';
import 'package:proyectos_abitalia/common/authentication/auth_login_form.dart';
import 'package:proyectos_abitalia/common/authentication/auth_presentation_mobile.dart';
import 'package:proyectos_abitalia/common/authentication/auth_presentation_web.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
          return Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenSize.height),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(128, 30, 130, 24),
                        //Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(128, 199, 31, 0)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  width: screenSize.width,
                  height: screenSize.height,
                  padding:
                  screenSize.width < 786 ?
                  EdgeInsets.only(top: 80, bottom: 80, left: 20, right: 20) :
                  EdgeInsets.only(top: 60, bottom: 60, left: 120, right: 120),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: Container(
                      child:
                      screenSize.width < 786 ? Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child:
                            AuthPresentationMobile()
                          ),
                          Expanded(
                            flex: 3,
                            child: AuthLoginForm(),
                          ),
                        ],
                      ) : Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                              AuthPresentationWeb()
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 80),
                              child: AuthLoginForm(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
