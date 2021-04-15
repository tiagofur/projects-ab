import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';
import 'package:proyectos_abitalia/models/client_manager.dart';
import 'package:proyectos_abitalia/models/project_manager.dart';
import 'package:proyectos_abitalia/screens/base/base_screen.dart';
import 'package:proyectos_abitalia/screens/auth/login_screen.dart';
import 'package:proyectos_abitalia/screens/auth/signup_screen.dart';
import 'package:proyectos_abitalia/screens/clients/clients_screen.dart';
import 'package:proyectos_abitalia/screens/clients/create_client_screen.dart';
import 'package:proyectos_abitalia/screens/home/home_screen.dart';
import 'package:proyectos_abitalia/screens/projects/create_project_screen.dart';
import 'package:proyectos_abitalia/screens/projects/projects_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppUserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ClientManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProjectManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Projectos Abitalia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          accentColor: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            // PROJECTS
            case '/projects':
              return MaterialPageRoute(builder: (_) => ProjectsScreen());
            case '/createProject':
              return MaterialPageRoute(builder: (_) => CreateProjectScreen());
            //CLIENTS
            case '/clients':
              return MaterialPageRoute(builder: (_) => ClientsScreen());
            case '/createClient':
              return MaterialPageRoute(builder: (_) => CreateClientScreen());
            //LOGIN //REGISTRAR
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(), settings: settings);
          }
        },
      ),
    );
  }
}
