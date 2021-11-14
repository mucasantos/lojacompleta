import 'package:flutter/material.dart';
import 'package:lojacompleta/models/home_manager.dart';
import 'package:lojacompleta/models/section.dart';

class AddSection extends StatelessWidget {
  const AddSection({Key key, this.homeManager}) : super(key: key);

  final HomeManager homeManager;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            child: const Text(
              'Adicionar Lista',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            child: const Text(
              'Adicionar Grade',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
