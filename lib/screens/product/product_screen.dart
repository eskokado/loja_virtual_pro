import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_manager.dart';
import '../../models/product.dart';
import '../../models/user_manager.dart';
import '../products/components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: [
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        '/edit_product',
                        arguments: product,
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: CarouselSlider(
                items: product.images
                    .map((url) => Container(
                            child: Image(
                          image: NetworkImage(url),
                        )))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((s) {
                      return SizeWidget(size: s);
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              onSurface:
                                  Theme.of(context).primaryColor.withAlpha(100),
                              primary: Theme.of(context).primaryColor,
                            ),
                            onPressed: product.selectedSize != null
                                ? () {
                                    if (userManager.isLoggedIn) {
                                      context
                                          .read<CartManager>()
                                          .addToCart(product);
                                      Navigator.of(context).pushNamed('/cart');
                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                    }
                                  }
                                : null,
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao Carrinho'
                                  : 'Entre para Comprar',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
          child: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
