import 'package:flutter/material.dart';

import '../../../models/section.dart';
import 'section_header.dart';

class SectionList extends StatelessWidget {
  const SectionList({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(
            section: section,
          ),
        ],
      ),
    );
  }
}
