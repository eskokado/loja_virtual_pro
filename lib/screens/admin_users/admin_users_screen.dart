import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_drawer/custom_drawer.dart';
import '../../models/admin_users_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetScrollView(
            list: adminUsersManager.names.map((e) => AlphaModel(e)).toList(),
            alignment: LetterAlignment.right,
            unselectedTextStyle:
                const TextStyle(color: Colors.white, fontSize: 20),
            selectedTextStyle:
                const TextStyle(color: Colors.white, fontSize: 24),
            overlayWidget: (value) => Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 50,
                  color: Colors.red,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Theme.of(context).primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    value.toUpperCase(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            itemBuilder: (_, index, id) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
