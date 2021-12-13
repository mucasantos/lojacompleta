import 'dart:developer';

import 'package:brasil_fields/formatter/cep_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojacompleta/models/address.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/services/cepaberto_services.dart';
import 'package:lojacompleta/widgets/custom_item_button.dart';
import 'package:provider/src/provider.dart';

class CepInputField extends StatelessWidget {
  CepInputField({Key key, this.address}) : super(key: key);

  final Address address;
  TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (address.zipCode == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
              controller: cepController,
              decoration: InputDecoration(
                  isDense: true, labelText: 'CEP', hintText: '12.345-678'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
              keyboardType: TextInputType.number,
              validator: (cep) {
                if (cep.isEmpty) {
                  return 'Campo obrigatório!';
                } else if (cep.length != 10) {
                  return 'CEP inválido!';
                }

                return null;
              }),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xffCC667D),
                onSurface: Color(0xffCC667D).withAlpha(50)),
            onPressed: () {
              if (Form.of(context).validate()) {
                context.read<CartManager>().getAddress(cepController.text);
              }
            },
            child: Text('Buscar CEP'),
          )
        ],
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              'CEP:  ${address.zipCode} ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
            CustomIconButton(
              color: Color(0xffCC667D),
              iconData: Icons.edit,
              size: 20,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
  }
}
