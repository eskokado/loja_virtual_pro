import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({Key? key, required this.size}) : super(key: key);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
