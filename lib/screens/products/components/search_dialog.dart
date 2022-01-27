import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({Key? key, required this.initialText}) : super(key: key);

  final String initialText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              autofocus: true,
              initialValue: initialText,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.grey[700],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
