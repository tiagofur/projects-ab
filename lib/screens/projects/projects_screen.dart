import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/common/custom_drawer/custom_drawer.dart';
import 'package:proyectos_abitalia/models/project_manager.dart';
import 'package:proyectos_abitalia/screens/projects/components/card_project_mobile.dart';
import 'package:proyectos_abitalia/screens/projects/components/card_project_web.dart';
import 'package:proyectos_abitalia/screens/projects/components/create_project_floatbutton.dart';

class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
          title: Text('Proyectos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(),
          body: Stack(
            children: <Widget>[
              Container(
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
              ),
              Container(
                child: Consumer<ProjectManager>(builder: (_, projectManager, __) {
                  final filteredProjects = projectManager.filteredProjects;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: ListView.builder(
                          itemCount: filteredProjects.length,
                          itemBuilder: (_, index) {
                            if(screenSize.width < 768)
                              return CardProjectMobile(filteredProjects[index]);
                            else
                              return CardProjectWeb(filteredProjects[index]);
                          }
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          floatingActionButton: CreateProjectFloatButton(),
        );
  }
}
