import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/section.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Text(
      section.name,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    );
  }
}
