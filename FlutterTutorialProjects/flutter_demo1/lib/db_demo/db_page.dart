import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'employee.dart';
import 'dart:async';

class DBTestPage extends StatefulWidget {
  final String title;

  DBTestPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBTestPageState();
  }
}

class _DBTestPageState extends State<DBTestPage> {
  Future<List<Employee>> employees;
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;

  final formKey = new GlobalKey<FormState>();
  var dbHelper = DBHelper();
  bool isUpdating = false;

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Employee e = new Employee(curUserId, name);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
        clearName();
      } else {
        Employee e = new Employee(null, name);
        dbHelper.save(e);
      }
      refreshList();
      clearName();
    }
  }

  refreshList() {
    setState(() {
      employees = dbHelper.getEmployees();
    });
  }

  clearName() {
    controller.text = '';
  }

  SingleChildScrollView dataBody(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("NAME"),
          ),
          DataColumn(
            label: Text("DELETE"),
          ),
        ],
        rows: employees
            .map(
              (employee) => DataRow(
                    cells: [
                      DataCell(Text(employee.name), onTap: () {
                        setState(() {
                          isUpdating = true;
                          curUserId = employee.id;
                        });
                        controller.text = employee.name;
                      }),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            dbHelper.delete(employee.id);
                            refreshList();
                          },
                        ),
                      )
                    ],
                  ),
            )
            .toList(),
      ),
    );
  }

  form() {
    return Form(
      key: formKey,
      child: new Padding(
        padding: new EdgeInsets.all(15.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new TextFormField(
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'Name'),
                validator: (val) => val.length == 0 ? "Enter Name" : null,
                onSaved: (val) => name = val,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new OutlineButton(
                    onPressed: validate,
                    child: new Text(isUpdating ? 'UPDATE' : 'ADD'),
                  ),
                  new OutlineButton(
                    onPressed: () {
                      setState(() {
                        isUpdating = false;
                      });
                      clearName();
                    },
                    child: new Text('CANCEL'),
                  ),
                ],
              )
            ]),
      ),
    );
  }

  list() {
    return Expanded(
      child: new FutureBuilder(
        future: employees,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataBody(snapshot.data);
          }
          if (null == snapshot.data || snapshot.data.length == 0) {
            return new Text("No Records Found");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter SQLITE CRUD DEMO'),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
