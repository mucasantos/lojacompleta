import 'package:flutter/material.dart';
import 'package:lojacompleta/widgets/custom_drawer/drawer.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Produtos'),
      ),
    );
  }
}
