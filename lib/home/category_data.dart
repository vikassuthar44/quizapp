import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  late String name;
  String? hindiName = "";
  late String bg;
  late DocumentReference docId;

  Category({required this.name,this.hindiName, required this.bg, required this.docId});

  Category.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    name = doc.data()!['catName'];
    bg = doc.data()!['bg'];
    docId = doc.data()!['docId'];
  }
}