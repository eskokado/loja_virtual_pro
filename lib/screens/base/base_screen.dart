import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';

import '../../common/custom_drawer/custom_drawer.dart';
import '../../models/page_manager.dart';
import '../home/home_screen.dart';
import '../products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(builder: (_, userManager, __) {
        return PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            const ProductsScreen(),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home3'),
              ),
            ),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home4'),
              ),
            ),
            if (userManager.adminEnabled) ...[
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Usuários'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Pedidos'),
                ),
              ),
            ]
          ],
        );
      }),
    );
  }
}
