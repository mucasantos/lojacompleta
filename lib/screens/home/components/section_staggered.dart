import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojacompleta/models/home_manager.dart';
import 'package:lojacompleta/models/section.dart';
import 'package:lojacompleta/screens/home/components/add_tile_widget.dart';
import 'package:lojacompleta/screens/home/components/item-tile.dart';
import 'package:lojacompleta/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(section),
            Consumer<Section>(builder: (_, section, __) {
              return StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: homeManager.editing
                    ? section.items.length + 1
                    : section.items.length,
                itemBuilder: (_, index) {
                  if (index < section.items.length) {
                    return ItemTile(section.items[index]);
                  } else {
                    return AddTileWidget(
                      section: section,
                    );
                  }
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 1),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              );
            })
          ],
        ),
      ),
    );
  }
}
