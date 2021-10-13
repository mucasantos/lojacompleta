import 'package:flutter/material.dart';
import 'package:lojacompleta/models/section.dart';
import 'package:lojacompleta/screens/home/components/item-tile.dart';
import 'package:lojacompleta/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          SizedBox(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return ItemTile(section.items[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(
                        width: 4,
                      ),
                  itemCount: section.items.length)),
        ],
      ),
    );
  }
}
