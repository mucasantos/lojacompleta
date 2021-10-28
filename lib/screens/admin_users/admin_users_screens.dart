import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/admin_users_manager.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Usuários'),
          centerTitle: true,
        ),
        body: Consumer<AdminUsersManager>(builder: (_, adminUserManager, __) {
          return AlphabetListScrollView(
              indexedHeight: (indext) => 80,
              strList: adminUserManager.name,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(adminUserManager.users[index].name),
                  subtitle: Text(adminUserManager.users[index].email),
                );
              });
        }));
  }
}
