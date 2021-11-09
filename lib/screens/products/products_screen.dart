import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product_manager.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/products/components/product_list_tile.dart';
import 'package:lojacompleta/screens/products/components/search_dialog.dart';
import 'package:lojacompleta/widgets/custom_drawer/drawer.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF66CCB5),
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return Text('Produtos');
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(
                              productManager.search,
                            ));

                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )),
                );
              });
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search));

                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  icon: Icon(
                    Icons.search,
                  ));
            } else {
              return IconButton(
                  onPressed: () async {
                    productManager.search = '';
                  },
                  icon: Icon(
                    Icons.close,
                  ));
            }
          }),
          Consumer<UserManager>(builder: (_, userManager, __) {
            if (userManager.userIsAdmin)
              return IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/edit',
                    );
                  },
                  icon: Icon(Icons.add));
            return Container();
          })
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(
                filteredProducts[index],
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
