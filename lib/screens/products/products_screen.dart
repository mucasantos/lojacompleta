import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product_manager.dart';
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
              ))
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
    );
  }
}
