import 'package:flutter/material.dart';
import 'package:proyectos_abitalia/common/custom_drawer/custon_drawer_header.dart';
import 'package:proyectos_abitalia/common/custom_drawer/drawer_tile.dart';

// ignore: use_key_in_widget_constructors
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(210, 140, 86, 86),
                  Color.fromARGB(50, 140, 86, 86)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
          ListView(
            children: <Widget>[
              CustonDrawerHeader(),
              const Divider(),
              const DrawerTile(iconData: Icons.list, title: 'Home', page: 5,),
              const DrawerTile(iconData: Icons.home, title: 'Proyectos', page: 4,),
              const DrawerTile(iconData: Icons.list, title: 'Clientes', page: 3,),
              //const DrawerTile(iconData: Icons.playlist_add_check, title: 'Mis Pedidos', page: 2,),
              //const DrawerTile(iconData: Icons.location_on, title: 'Tiendas', page: 3,),
              //Consumer<AppUserManager>(
              //  builder: (_, userManager, __){
              //    if(userManager.isAdmin){
              //      return Column(
              //        children: <Widget>[
              //          const Divider(),
              //          if(userManager.adminUsers)
              //          const DrawerTile(
              //            iconData: Icons.group,
              //            title: 'Usuarios',
              //            page: 4,
              //          ),
              //          if(userManager.adminOrders)
              //          const DrawerTile(
              //            iconData: Icons.content_paste,
              //            title: 'Pedidos',
              //            page: 5,
              //          ),
              //        ],
              //      );
              //    } else {
              //      return Container();
              //    }
              //  },
              //),
            ],
          ),
        ],
      ),
    );
  }
}
