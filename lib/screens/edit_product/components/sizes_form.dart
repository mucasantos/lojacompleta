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
    return FormField<List<ItemSize>>(
        initialValue: product.sizes,
        validator: (sizes) {
          if (sizes.isEmpty) return 'Insira um tamanho!';

          return null;
        },
        builder: (state) {
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
                    onTap: () {
                      state.value.add(ItemSize());
                      state.didChange(state.value);
                    },
                  ),
                ],
              ),
              Column(
                children: state.value.map((size) {
                  return EditItemSize(
                    key: ObjectKey(size),
                    size: size,
                    onRemove: () {
                      state.value.remove(size);
                      state.didChange(state.value);
                    },
                    onMoveDown: size != state.value.last
                        ? () {
                            final index = state.value.indexOf(size);
                            state.value.remove(size);
                            state.value.insert(index + 1, size);
                            state.didChange(state.value);
                          }
                        : null,
                    onMoveUp: size != state.value.first
                        ? () {
                            final index = state.value.indexOf(size);
                            state.value.remove(size);
                            state.value.insert(index - 1, size);
                            state.didChange(state.value);
                          }
                        : null,
                  );
                }).toList(),
              ),
              Visibility(
                  visible: state.hasError,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
            ],
          );
        });
  }
}
