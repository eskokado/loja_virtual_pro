import 'package:flutter/material.dart';

import '../../../models/item_size.dart';
import '../../../models/product.dart';
import 'edit_item_size.dart';

class SizesForm extends StatelessWidget {
  const SizesForm({ Key? key, required this.product }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state){
        return Column(
          children: state.value!.map((size){
            return EditItemSize(
              size: size,
            );
          }).toList(),
        );
      },
    );
  }
}