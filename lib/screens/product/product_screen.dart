import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product.model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
        ),
      ),
      backgroundColor: Colors.white,
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
                    "R\$19.00",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
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
                ],
              ))
        ],
      ),
    );
  }
}
