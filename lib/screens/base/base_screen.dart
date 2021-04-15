import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyectos_abitalia/models/app_user_manager.dart';
import 'package:proyectos_abitalia/models/page_manager.dart';
import 'package:proyectos_abitalia/screens/account/account_screen.dart';
import 'package:proyectos_abitalia/screens/auth/login_screen.dart';
import 'package:proyectos_abitalia/screens/auth/signup_screen.dart';
import 'package:proyectos_abitalia/screens/clients/clients_screen.dart';
import 'package:proyectos_abitalia/screens/home/home_screen.dart';
import 'package:proyectos_abitalia/screens/projects/projects_screen.dart';

// ignore: use_key_in_widget_constructors
class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<PageManager> (
      create: (_) => PageManager(pageController),
      child: Consumer<AppUserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              LoginScreen(),    // 0
              SignUpScreen(),   // 1
              AccountScreen(),  // 2
              ClientsScreen(),  // 3
              ProjectsScreen(), // 4
              HomeScreen(),     // 5
              //ProductsScreen(),
              //OrdersScreen(),
              //StoresScreen(),
              //if(userManager.isAdmin)
              //...[
                  //if(userManager.adminUsers)
                    //AdminUserScreen(),
                  //if(userManager.adminOrders)
                    //AdminOrdersScreen(),
                //],
            ],
          );
        },
      )
    );
  }
}
