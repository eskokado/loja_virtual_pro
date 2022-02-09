import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document) {
    name = document['name'] as String;
    type = document['type'] as String;
  }

  String name = '';
  String type = '';
}
