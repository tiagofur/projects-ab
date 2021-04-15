import 'package:flutter/material.dart';

class AuthPresentationMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
            color: Colors.red,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 16, right: 8, left: 8),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.black87,
                    backgroundImage: AssetImage('assets/images/bandera.jpg'),
                    radius: 50,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "PROYECTOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "Mantenga sus proyectos organizados y visibles a todo equipo.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
