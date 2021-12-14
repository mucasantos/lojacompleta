import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:provider/src/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key key,
    this.buttonText,
    this.onPressed,
    this.color,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final deliveryPrice = cartManager.deliveryPrice;
    final productsPrice = cartManager.productsPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      color: color ?? Color(0xFF66CCB5),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do pedido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}'),
              ],
            ),
            const Divider(
              thickness: 2.0,
            ),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Entrega'),
                  Text('R\$ ${deliveryPrice.toStringAsFixed(2)}'),
                ],
              ),
              const Divider(
                thickness: 2.0,
              ),
            ],
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'R\$ ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffCC667D),
                    onSurface: Color(0xffCC667D).withAlpha(50)),
                onPressed: onPressed,
                child: Text(buttonText))
          ],
        ),
      ),
    );
  }
}
