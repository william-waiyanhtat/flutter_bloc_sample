import 'package:flutter/material.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record.dart';

class FBRealTimeDB extends StatefulWidget {
  FBRealTimeDB() : super();

  final String title = "Firebase Realtime DB";
  @override
  FBRealTimeDBState createState() => FBRealTimeDBState();
}

class FBRealTimeDBState extends State<FBRealTimeDB> {
  //

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    print("here");
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

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
          onTap: () => Firestore.instance.runTransaction((transaction) async {
                final freshSnapshot = await transaction.get(record.reference);
                final fresh = Record.fromSnapshot(freshSnapshot);

                // await transaction
                //     .update(record.reference, {'name': fresh.name + "11"});
                await transaction
                    .set(record.reference, {'name4': 'New Value4'});
              }),
        ),
      ),
    );
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
                  // Firestore.instance
                  //     .collection('baby')
                  //     .document('Baby3')
                  //     .setData({'name': 'My Baby3'});

                  await Firestore.instance
                      .collection('baby')
                      .document('dana')
                      .setData({'name': 'Name1'});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
