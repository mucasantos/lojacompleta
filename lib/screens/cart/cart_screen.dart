import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/screens/cart/components/cart_tile.dart';
import 'package:lojacompleta/widgets/price_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF66CCB5),
        title: const Text('Carrinho'),
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              PriceCard(),
            ],
          );
        },
      ),
    );
  }
}
