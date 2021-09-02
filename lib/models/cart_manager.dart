import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojacompleta/models/cart_product.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';

class CartManager {
  List<CartProduct> items = [];

  User user;

  void updateUser(UserManager userManager) {
    user = userManager.user;

    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  _loadCartItems() async {
    final QuerySnapshot carSnap = await user.cartReference.getDocuments();

    items =
        carSnap.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
  }

  void addToCart(Product product) {
    try {
      final entite = items.firstWhere((element) => element.stackable(product));
      entite.quantity++;
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap());
    }
  }
}
