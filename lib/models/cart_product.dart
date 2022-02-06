import 'product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  String productId = '';
  int quantity = 0;
  String size = '';

  Product product;
}
