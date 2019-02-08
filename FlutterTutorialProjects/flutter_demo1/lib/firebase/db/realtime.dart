import 'package:flutter/material.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record.dart';

class FireBaseFireStoreDemo extends StatefulWidget {
  FireBaseFireStoreDemo() : super();

  final String title = "Firebase Realtime DB";
  @override
  FireBaseFireStoreDemoState createState() => FireBaseFireStoreDemoState();
}

class FireBaseFireStoreDemoState extends State<FireBaseFireStoreDemo> {
  //

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          onTap: () {
            update(record, record.name + "_new");
          },
        ),
      ),
    );
  }

  getUsers() {
    return Firestore.instance.collection('baby').snapshots();
  }

  add(User user) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference collectionReference =
          Firestore.instance.collection("baby");
      await collectionReference.add({"name": "New Baby"});
    });
  }

  delete(var record) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(record.reference);
    });
  }

  update(var record, String newName) {
    Firestore.instance.runTransaction((transaction) async {
      // final freshSnapshot = await transaction.get(record.reference);
      // final fresh = Record.fromSnapshot(freshSnapshot);
      await transaction.update(record.reference, {'name': newName});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: _buildBody(context),
              ),
              OutlineButton(
                child: Text("Save"),
                onPressed: () async {
                  User user = User("Vipin", "Vijayan");
                  add(user);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
