import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/product.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state) {
        return Container();
      },
    );
  }
}
