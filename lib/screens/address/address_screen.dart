import 'package:flutter/material.dart';
import 'package:lojacompleta/screens/address/components/address_card.dart';

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
        children: [AddressCard()],
      ),
    );
  }
}
