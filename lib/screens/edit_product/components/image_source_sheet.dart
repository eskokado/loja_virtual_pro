import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({Key? key, required this.onImageSelected}) : super(key: key);

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final XFile? file =
                    await picker.pickImage(source: ImageSource.camera);
                if (file != null) onImageSelected(File(file.path));
              },
              child: const Text('Câmera'),
            ),
            ElevatedButton(
              onPressed: () async {
                final XFile? file =
                    await picker.pickImage(source: ImageSource.gallery);
                if (file != null) onImageSelected(File(file.path));
              },
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Galeria'),
          )
        ],
      );
  }
}
