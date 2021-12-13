import 'package:flutter/material.dart';
import 'package:lojacompleta/models/address.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField({Key key, this.address}) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av. Brasil',
          ),
          validator: emptyValidator,
          onSaved: (text) => address.state = text,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Número',
                  hintText: '123',
                ),
                validator: emptyValidator,
                onSaved: (text) => address.number = text,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: '123',
                ),
                onSaved: (text) => address.complement = text,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: address.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro',
            hintText: 'Bodocongó',
          ),
          validator: emptyValidator,
          onSaved: (text) => address.district = text,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: address.city,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Cidade',
                  hintText: 'Campina Grande',
                ),
                validator: emptyValidator,
                onSaved: (text) => address.city = text,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                enabled: false,
                initialValue: address.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Estado',
                  hintText: 'SP',
                ),
                validator: emptyValidator,
                onSaved: (text) => address.state = text,
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xffCC667D),
              onSurface: Color(0xffCC667D).withAlpha(50)),
          onPressed: () {},
          child: Text('Calcular Frete'),
        )
      ],
    );
  }
}
