import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/admin_users_manager.dart';
import 'package:lojacompleta/widgets/custom_drawer/drawer.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text('Usuários'),
          centerTitle: true,
        ),
        body: Consumer<AdminUsersManager>(builder: (_, adminUserManager, __) {
          return AlphabetListScrollView(
              indexedHeight: (indext) => 80,
              strList: adminUserManager.name,
              showPreview: true,
              itemBuilder: (_, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(adminUserManager
                                .users[index].userImage ??
                            'https://qph.fs.quoracdn.net/main-qimg-f521020f4e9761f812d1dd8e1de32ebb-c')),
                    title: Text(adminUserManager.users[index].name),
                    subtitle: Text(adminUserManager.users[index].email),
                  ),
                );
              });
        }));
  }
}
