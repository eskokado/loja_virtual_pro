import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';

import 'cart_product.dart';
import 'product.dart';

class CartManager {
  CartManager() {
    if (user != null) {
      _loadCartItems();
    }
  }

  List<CartProduct> items = [];

  User? user;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user!.cartReference.get();

    items = cartSnap.docs.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
    print(items);
  }
}
