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
  TextEditingController controller = TextEditingController();
  bool showTextField = false;
  bool isEditing = false;
  Record curRecord;
  String btnText;

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
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print("Deleting Record");
              delete(record);
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print("Editing Record");
              setUpdateUI(record);
            },
          ),
          title: Text(record.name),
          onTap: () {
            setUpdateUI(record);
          },
        ),
      ),
    );
  }

  setUpdateUI(Record record) {
    controller.text = record.name;
    setState(() {
      showTextField = true;
      isEditing = true;
      curRecord = record;
    });
  }

  getUsers() {
    return Firestore.instance.collection('baby').snapshots();
  }

  add() async {
    // Firestore.instance.runTransaction((Transaction transaction) async {
    //   CollectionReference collectionReference =
    //       Firestore.instance.collection("baby");
    //   await collectionReference.add({'name': 'NewBaby'});
    // });

    if (isEditing) {
      print("Updating...");
      update(curRecord, controller.text);
      setState(() {
        isEditing = false;
      });
      controller.text = '';
      return;
    }

    Record user = Record(name: controller.text);
    user.name = controller.text;
    try {
      await Firestore.instance
          .collection('baby')
          .document('Babies')
          .setData(<String, dynamic>{'name': user.name});
    } catch (e) {
      print(e.toString());
    }
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
                controller.text = '';
                isEditing = false;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            showTextField
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Enter name",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlineButton(
                        child: Text(isEditing ? "UPDATE" : "ADD"),
                        onPressed: () async {
                          add();
                          //print(controller.text);
                          setState(() {
                            showTextField = !showTextField;
                          });
                        },
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            Text(
              "DATA",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }
}
