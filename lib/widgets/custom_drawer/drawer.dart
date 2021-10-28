import 'package:flutter/material.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/widgets/custom_drawer/custom_drawer_header.dart';
import 'package:lojacompleta/widgets/custom_drawer/drawer_tile.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 203, 236, 241),
              Colors.white
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                iconData: Icons.home,
                title: "Início",
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: "Produtos",
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: "Meus Pedidos",
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: "Lojas",
                page: 3,
              ),
              Consumer<UserManager>(builder: (_, userManager, __) {
                if (userManager.userIsAdmin) {
                  return Column(
                    children: [
                      const Divider(),
                      DrawerTile(
                        iconData: Icons.settings,
                        title: 'Usuários',
                        page: 4,
                      ),
                      DrawerTile(
                        iconData: Icons.settings,
                        title: 'Pedidos',
                        page: 5,
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ],
      ),
    );
  }
}
