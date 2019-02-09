import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String name;
  DocumentReference reference;

  Record({this.name});

  Record.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map['name'];
  }

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
