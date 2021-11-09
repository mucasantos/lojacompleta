import 'package:flutter/material.dart';
import 'package:lojacompleta/models/item_size.dart';
import 'package:lojacompleta/widgets/custom_item_button.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveDown, this.onMoveUp})
      : super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if (name.isEmpty) return 'Inválido!';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            validator: (stock) {
              if (int.tryParse(stock) == null) return 'Inválido!';
              return null;
            },
            keyboardType: TextInputType.number,
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
                labelText: 'Valor', isDense: true, prefixText: 'R\$'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price) == null) return 'Inválido!';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
      ],
    );
  }
}
