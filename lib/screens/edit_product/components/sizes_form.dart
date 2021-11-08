import 'package:flutter/material.dart';
import 'package:lojacompleta/models/item_size.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/screens/edit_product/components/edit_item_size.dart';
import 'package:lojacompleta/widgets/custom_item_button.dart';

class SizesForm extends StatelessWidget {
  const SizesForm({Key key, this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Tamanhos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            CustomIconButton(
              iconData: Icons.add,
              color: Colors.black,
            ),
          ],
        ),
        FormField<List<ItemSize>>(
            initialValue: product.sizes,
            builder: (state) {
              return Column(
                children: state.value.map((size) {
                  return EditItemSize(
                    size: size,
                  );
                }).toList(),
              );
            }),
      ],
    );
  }
}
