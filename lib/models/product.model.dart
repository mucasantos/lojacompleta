import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojacompleta/models/item_size.dart';

class Product extends ChangeNotifier {
  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;

    images = List<String>.from(document.data['images'] as List<dynamic>);
    sizes = (document.data['sizes'] as List<dynamic> ?? [])
        .map((size) => ItemSize.fromMap(size as Map<String, dynamic>))
        .toList();
  }
  late String id;
  late String name;
  late String description;
  late List<String> images;
  late List<ItemSize> sizes;
  late ItemSize? _selectedSize;

  ItemSize get selectedSize => _selectedSize!;
  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  ItemSize? findSize(String sizeName) {
    try {
      return sizes.firstWhere((size) => size.name == sizeName);
    } catch (e) {
      return null;
    }
  }
}
