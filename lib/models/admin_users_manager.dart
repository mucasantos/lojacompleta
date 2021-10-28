import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];
  void updateUser(UserManager userManager) {
    if (userManager.userIsAdmin) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    final faker = Faker();
    for (int i = 0; i < 1000; i++) {
      users.add(User(name: faker.person.name(), email: faker.internet.email()));
    }
  }

  List<String> get name => users.map((e) => e.name).toList();
}
