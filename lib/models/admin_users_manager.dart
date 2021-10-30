import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.userIsAdmin) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    /*
    final faker = Faker();

    for (int i = 0; i < 100; i++) {
      users.add(User(
          name: faker.person.name(),
          email: faker.internet.email(),
          userImage: faker.image.image()));
    }
    */

/* 
firestore : collectio('nome da colect').getDocuments().then ---> não é tempo real
firestore : collectio('nome da colect').snapshots().listen ---> é tempo real
*/
    _subscription = firestore.collection('users').snapshots().listen((snashot) {
      users =
          snashot.documents.map((e) => User.fromDocument(document: e)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get name => users.map((e) => e.name).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
