import 'item_size.dart';
import 'product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product!.id;
    quantity = 1;
    size = product!.selectedSize.name;
  }

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
}