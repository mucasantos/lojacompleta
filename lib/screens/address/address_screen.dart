import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/screens/address/components/address_card.dart';
import 'package:lojacompleta/widgets/price_card.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF66CCB5),
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard(),
          Consumer<CartManager>(builder: (_, cartManager, __) {
            return PriceCard(
              color: Colors.white,
              buttonText: 'Continuar para o Pagamento',
              onPressed: cartManager.isAddressValid ? () {} : null,
            );
          })
        ],
      ),
    );
  }
}
