import 'package:flutter/material.dart';
import 'package:lojacompleta/models/address.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/screens/address/components/address_input_field.dart';
import 'package:lojacompleta/screens/address/components/cep_input_field.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Consumer<CartManager>(
            builder: (_, cartManager, __) {
              final address = cartManager.address ?? Address();
              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Endereço de entrega',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CepInputField(
                      address: address,
                    ),
                    Visibility(
                      visible: address.zipCode != null,
                      child: AddressInputField(
                        address: address,
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
