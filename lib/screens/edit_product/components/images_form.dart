// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:flutter/cupertino.dart';
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
      initialValue: List.from(widget.product.images),
      validator: (images) {
        if (images!.isEmpty) return 'Insira ao menos uma imagem';
        return null;
      },
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
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
                            if (Platform.isAndroid)
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                  onImageSelected: onImageSelected,
                                ),
                              );
                            else
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                  onImageSelected: onImageSelected,
                                ),
                              );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
