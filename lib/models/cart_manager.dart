import 'cart_product.dart';
import 'product.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
    print(items);
  }
}
