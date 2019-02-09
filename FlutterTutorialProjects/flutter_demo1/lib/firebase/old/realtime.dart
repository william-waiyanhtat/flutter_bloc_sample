import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class FireBaseFireStoreDemo extends StatefulWidget {
  FireBaseFireStoreDemo() : super();

  final String title = "CloudFireStore Demo";
  @override
  FireBaseFireStoreDemoState createState() => FireBaseFireStoreDemoState();
}

class FireBaseFireStoreDemoState extends State<FireBaseFireStoreDemo> {
  //
  String collectionName = 'Users';
  TextEditingController controller = TextEditingController();
  bool showTextField = false;
  bool isEditing = false;
  User curRecord;
  String btnText;

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return _buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = User.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              delete(record);
            },
          ),
          onTap: () {
            setUpdateUI(record);
          },
        ),
      ),
    );
  }

  setUpdateUI(User record) {
    controller.text = record.name;
    setState(() {
      showTextField = true;
      isEditing = true;
      curRecord = record;
    });
  }

  getUsers() {
    return Firestore.instance.collection(collectionName).snapshots();
  }

  add() async {
    if (isEditing) {
      update(curRecord, controller.text);
      setState(() {
        isEditing = false;
      });
    } else {
      addUser();
    }
    controller.text = '';
  }

  addUser() {
    User user = User(name: controller.text);
    try {
      Firestore.instance.runTransaction((Transaction transaction) async {
        // if you give the same document, then it will be overwritten
        await Firestore.instance.collection(collectionName).document().setData(
            user.toJson()); // you can manually specify the json as well
      });
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
      await transaction.update(record.reference, {'name': newName});
    });
  }

  button() {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        child: Text(isEditing ? "UPDATE" : "ADD"),
        onPressed: () async {
          add();
          setState(() {
            showTextField = !showTextField;
          });
        },
      ),
    );
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
        padding: EdgeInsets.all(20.0),
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
                      button(),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            Text(
              "USERS",
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
