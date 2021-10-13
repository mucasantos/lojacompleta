import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF66CCB5),
          title: Text(
            product.name,
          ),
        ),
        backgroundColor: const Color(0xFF66CCB5),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url) => NetworkImage(url)).toList(),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                // autoplay: false,
                dotSpacing: 15,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "A partir de",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Text(
                              product.sizes.first.price.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        if (product.hasStock)
                          Consumer2<UserManager, Product>(
                            builder: (_, userManager, product, __) {
                              return SizedBox(
                                height: 44,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xffCC667D)),
                                  onPressed: product.selectedSize != null
                                      ? () {
                                          if (userManager.isLoggedIn) {
                                            context
                                                .read<CartManager>()
                                                .addToCart(product);
                                            Navigator.of(context)
                                                .pushNamed('/cart');
                                          } else {
                                            Navigator.of(context)
                                                .pushNamed('/login');
                                          }
                                        }
                                      : null,
                                  child: Text(
                                    userManager.isLoggedIn
                                        ? 'Adicionar ao carrinho'
                                        : 'Entre para comprar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              );
                            },
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        "Descrição",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                        "Tamanhos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes.map((e) {
                        return SizeWidget(size: e);
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
