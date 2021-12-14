import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lojacompleta/models/address.dart';
import 'package:lojacompleta/models/cart_product.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/services/cepaberto_services.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User user;
  Address address;

  num productsPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);
  bool _loading = false;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;

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

  bool get isAddressValid => address != null && deliveryPrice != null;

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      log(
        cepAbertoAddress.estado.sigla,
      );
      if (cepAbertoAddress != null) {
        address = Address(
          street: cepAbertoAddress.logradouro,
          district: cepAbertoAddress.bairro,
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.cidade.nome,
          state: cepAbertoAddress.estado.sigla,
          latitude: cepAbertoAddress.latitude,
          longitude: cepAbertoAddress.longitude,
        );

        //  notifyListeners();
        loading = false;
      }
    } catch (e) {
      loading = false;
      return Future.error('CEP não encontrado!');
    }
    loading = false;
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    if (await calculateDelivery(address.latitude, address.longitude)) {
      loading = false;
    } else {
      loading = false;
      return Future.error("Fora do raio de entrega");
    }
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.document('aux/delivery').get();

    final latStore = doc.data['lat'] as double;
    final longStore = doc.data['long'] as double;
    final maxKm = doc.data['maxKm'] as num;

    final perKm = doc.data['perKm'] as num;
    final priceBase = doc.data['priceBase'] as num;

    double distance =
        await Geolocator().distanceBetween(latStore, longStore, lat, long);

    distance /= 1000.0;

    deliveryPrice = priceBase + distance * perKm;

    if (distance > maxKm) {
      return false;
    }
    return true;
  }
}
