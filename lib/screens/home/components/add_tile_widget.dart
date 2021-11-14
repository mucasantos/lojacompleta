import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/section.dart';
import 'package:lojacompleta/models/section_item.dart';
import 'package:lojacompleta/screens/edit_product/components/imageSource-sheet.dart';

class AddTileWidget extends StatelessWidget {
  const AddTileWidget({Key key, this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
                context: context,
                builder: (context) => ImageSourceSheet(
                      onImageSelect: onImageSelected,
                    ));
          } else {
            showCupertinoModalPopup(
                context: context,
                builder: (context) => ImageSourceSheet(
                      onImageSelect: onImageSelected,
                    ));
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
