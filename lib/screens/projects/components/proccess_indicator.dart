import 'package:flutter/material.dart';
import 'package:proyectos_abitalia/models/project.dart';

class ProccessIndicator extends StatelessWidget {

  ProccessIndicator(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
      return Flex(
        direction: Axis.horizontal,
          children: [
            for (var i = 0; i < project.proccess.length; i++)
              Expanded(
                flex: 1,
                child: Container(
                  //width: MediaQuery.of(context).size.width / project.proccess.length - 16,
                  height: 10,
                  decoration: BoxDecoration(
                    color: project.proccess[i] == 0
                        ? Colors.grey[300]
                        : project.proccess[i] == 1
                        ? Colors.blue
                        : project.proccess[i] == 2
                        ? Colors.green
                        : project.proccess[i] == 3
                        ? Colors.red
                        : Colors.purple,
                    border: Border(
                      right: BorderSide(width: 1, color: Colors.white),
                      left: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
      );
  }
}
