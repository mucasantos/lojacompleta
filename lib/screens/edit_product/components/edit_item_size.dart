import 'package:flutter/material.dart';
import 'package:lojacompleta/models/item_size.dart';
import 'package:lojacompleta/widgets/custom_item_button.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({Key key, this.size}) : super(key: key);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: 'Tamanho',
              isDense: true,
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: 'Valor',
              isDense: true,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
        ),
      ],
    );
  }
}
