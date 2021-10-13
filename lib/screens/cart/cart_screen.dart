import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/screens/cart/components/cart_tile.dart';
import 'package:lojacompleta/widgets/price_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF66CCB5),
        title: const Text('Carrinho'),
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          if (cartManager.items.isEmpty)
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: Image.asset(
                  "images/empty-cart.gif",
                  scale: 4,
                ),
              ),
            );
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              PriceCard(
                buttonText: 'Continuar para entrega',
                onPressed: cartManager.isCartValid ? () {} : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
