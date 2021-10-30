import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/screens/edit_product/components/images-form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({Key key, this.product}) : super(key: key);
  final Product product;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF66CCB5),
        title: const Text('Editar produto'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ImagesForm(product: product),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (name) {
                      if (name.length < 6) {
                        return "Título muito curto!";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'A partir de ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ... ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    decoration: InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.length < 10) {
                        return "Descrição muito curto!";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        print('Valido');
                      else
                        print('inv;alidooooo');
                    },
                    child: const Text('Salvar'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
