import 'dart:developer';

import 'package:brasil_fields/formatter/cep_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojacompleta/models/address.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/services/cepaberto_services.dart';
import 'package:lojacompleta/widgets/custom_item_button.dart';
import 'package:provider/src/provider.dart';

class CepInputField extends StatefulWidget {
  CepInputField({this.address});

  final Address address;

  @override
  State<CepInputField> createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {
  TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    if (widget.address.zipCode == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
              enabled: !cartManager.loading,
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
          Visibility(
              visible: cartManager.loading,
              child: LinearProgressIndicator(
                color: Color(0xffCC667D),
                backgroundColor: Colors.transparent,
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xffCC667D),
                onSurface: Color(0xffCC667D).withAlpha(50)),
            onPressed: !cartManager.loading
                ? () async {
                    if (Form.of(context).validate()) {
                      try {
                        await context
                            .read<CartManager>()
                            .getAddress(cepController.text);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            '$e',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  }
                : null,
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
              'CEP:  ${widget.address.zipCode} ',
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
