import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  List<Product> allProducts = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    allProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }
}
