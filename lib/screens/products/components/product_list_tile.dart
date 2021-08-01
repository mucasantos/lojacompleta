import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product.model.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(this.product);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/product',
          arguments: product,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      )),
                  Text(
                    "R\$19,99",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
