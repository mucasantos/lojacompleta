import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/cart_product.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User user;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager) {
    user = userManager.user;

    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  _loadCartItems() async {
    final QuerySnapshot carSnap = await user.cartReference.getDocuments();

    items = carSnap.documents
        .map((doc) => CartProduct.fromDocument(doc)..addListener(_onItemUpdate))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final entite = items.firstWhere((element) => element.stackable(product));
      entite.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      _onItemUpdate();
    }
    notifyListeners();
  }

  void _onItemUpdate() {
    productsPrice = 0.0;
    for (int index = 0; index < items.length; index++) {
      final cartProduct = items[index];
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
        index--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
    print(productsPrice);
  }

  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((product) => product.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartReference
          .document(cartProduct.id)
          .updateData(cartProduct.toCartItemMap());
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}
