import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({Key key, this.onImageSelect}) : super(key: key);

  final ImagePicker picker = ImagePicker();
  final Function(File) onImageSelect;

  @override
  Widget build(BuildContext context) {
    Future<void> editImage(ImageSource imageSource) async {
      final PickedFile file = await picker.getImage(source: imageSource);

      final File croppedFile = await ImageCropper.cropImage(
          sourcePath: file.path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Editar a imagem',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white),
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

      if (croppedFile != null) {
        onImageSelect(croppedFile);
      }
    }

    if (Platform.isAndroid) {
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      editImage(ImageSource.camera);
                    },
                    child: const Text('Câmera'),
                  ),
                  TextButton(
                    onPressed: () async {
                      editImage(ImageSource.gallery);
                    },
                    child: const Text('Galeria'),
                  ),
                ],
              ));
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem das fotos'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Galeria'),
          )
        ],
      );
    }
  }
}
