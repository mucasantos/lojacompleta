import 'package:flutter/material.dart';
import 'package:lojacompleta/models/page_manager.dart';
import 'package:lojacompleta/screens/home/homescreen.dart';
import 'package:lojacompleta/screens/login/login_screen.dart';
import 'package:lojacompleta/screens/products/products_screen.dart';
import 'package:lojacompleta/widgets/custom_drawer/drawer.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //HomeScreen(),
          //LoginScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home4'),
            ),
          ),
        ],
      ),
    );
  }
}
