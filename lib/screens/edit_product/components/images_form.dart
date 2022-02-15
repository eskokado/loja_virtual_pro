// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:loja_virtual_pro/screens/edit_product/components/image_source_sheet.dart';

import '../../../models/product.dart';

class ImagesForm extends StatefulWidget {
  const ImagesForm({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ImagesForm> createState() => _ImagesFormState();
}

class _ImagesFormState extends State<ImagesForm> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: widget.product.images,
      builder: (state) {
        return AspectRatio(
          aspectRatio: 1,
          child: InfiniteCarousel.builder(
            itemCount: state.value == null ? 0 : state.value!.length,
            itemExtent: MediaQuery.of(context).size.width,
            onIndexChanged: (index) {
              if (_selectedIndex != index) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            itemBuilder: (context, itemIndex, realIndex) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (state.value![itemIndex] is String)
                    Image.network(
                      state.value![itemIndex] as String,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.file(
                      state.value![itemIndex] as File,
                      fit: BoxFit.cover,
                    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      color: Colors.red,
                      onPressed: () {
                        if (state.value![itemIndex] != null) {
                          state.value!.remove(state.value![itemIndex]);
                          state.didChange(state.value);
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: Theme.of(context).primaryColor,
                      iconSize: 50,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => const ImageSourceSheet(),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
