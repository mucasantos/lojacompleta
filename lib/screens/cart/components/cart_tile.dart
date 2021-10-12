import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_product.dart';
import 'package:lojacompleta/widgets/custom_item_button.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);

  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        color: const Color(0xFF66CCB5),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  cartProduct.product.images.first,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduct, __) {
                        if (cartProduct.hasStock)
                          return Text(
                            'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          );
                        else
                          return Text('Sem estoque suficiente',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ));
                      })
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, cartProduct, __) {
                return Column(
                  children: [
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Colors.white,
                      onTap: cartProduct.increment,
                    ),
                    Text(
                      '${cartProduct.quantity}',
                      style: TextStyle(fontSize: 20),
                    ),
                    CustomIconButton(
                      iconData: Icons.remove,
                      color:
                          cartProduct.quantity > 1 ? Colors.white : Colors.red,
                      onTap: cartProduct.decrement,
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
