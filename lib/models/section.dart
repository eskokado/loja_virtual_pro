import 'package:cloud_firestore/cloud_firestore.dart';

import 'section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document) {
    name = document['name'] as String;
    type = document['type'] as String;
    items = (document['items'] as List)
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }

  String name = '';
  String type = '';
  List<SectionItem> items = [];

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
