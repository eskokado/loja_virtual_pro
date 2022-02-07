import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'item_size.dart';
import 'product.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this.product) {
    productId = product!.id;
    quantity = 1;
    size = product!.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document['pid'] as String;
    quantity = document['quantity'] as int;
    size = document['size'] as String;

    firestore
        .collection('users')
        .doc(productId)
        .get()
        .then((doc) => product = Product.fromDocument(doc));
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id = '';

  String productId = '';
  int quantity = 0;
  String size = '';

  Product? product;

  ItemSize? get itemSize {
    if (product == null) return null;
    return product?.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }
}
