import 'package:flutter/material.dart';

class AuthPresentationWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
            color: Colors.red,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20),
              bottomLeft: const Radius.circular(20),
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.black87,
                    backgroundImage: AssetImage('assets/images/bandera.jpg'),
                    radius: 70.0,
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    "PROYECTOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    "Mantenga sus proyectos organizados y visibles a todo equipo.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      ">",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
