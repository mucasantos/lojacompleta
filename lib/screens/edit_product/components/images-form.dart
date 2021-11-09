import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/screens/edit_product/components/imageSource-sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
        validator: (images) {
          if (images.isEmpty) {
            return 'Insira ao menos uma imagem';
          }
          return null;
        },
        initialValue: List.from(product.images),
        onSaved: (images) => product.newImages = images,
        builder: (stateImage) {
          void onImageSelected(File file) {
            stateImage.value.add(file);
            stateImage.didChange(stateImage.value);
            Navigator.of(context).pop();
          }

          return Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  autoplay: false,
                  images: stateImage.value.map<Widget>((image) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        if (image is String)
                          Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.file(
                            image as File,
                            fit: BoxFit.cover,
                          ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              stateImage.value.remove(image);
                              stateImage.didChange(stateImage.value);
                            },
                          ),
                        )
                      ],
                    );
                  }).toList()
                    ..add(Material(
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          if (Platform.isAndroid) {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                      onImageSelect: onImageSelected,
                                    ));
                          } else {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                      onImageSelect: onImageSelected,
                                    ));
                          }
                        },
                        child: Image.asset(
                          "images/take-photo.gif",
                          scale: 1,
                        ),
                      ),
                    )),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  // autoplay: false,
                  dotSpacing: 15,
                ),
              ),
              Visibility(
                  visible: stateImage.hasError,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      stateImage.errorText ?? '',
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
