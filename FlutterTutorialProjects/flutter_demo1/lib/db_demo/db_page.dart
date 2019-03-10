import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'employee.dart';
import 'dart:async';
import 'form.dart';

class DBTestPage extends StatefulWidget {
  final String title;

  DBTestPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBTestPageState();
  }
}

class _DBTestPageState extends State<DBTestPage> {
  var dbHelper = DBHelper();
  Future<List<Employee>> employees;

  refreshList() {
    setState(() {
      employees = dbHelper.getEmployees();
    });
  }

  void saveToDB(firstName, lastName) {
    Employee e = new Employee(null, firstName, lastName);
    dbHelper.save(e);
    refreshList();
  }

  SingleChildScrollView dataBody(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("F NAME"),
          ),
          DataColumn(
            label: Text("L NAME"),
          ),
          DataColumn(
            label: Text("DELETE"),
          ),
        ],
        rows: employees
            .map(
              (user) => DataRow(
                    cells: [
                      DataCell(Text(user.firstname), onTap: () {
                        Employee e = new Employee(user.id, 'xxx', 'yyy');
                        dbHelper.update(e);
                        refreshList();
                      }),
                      DataCell(
                        Text(user.lastname),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // delete
                            //delete(user);
                            print("ID : ${user.id}");
                            dbHelper.delete(user.id);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter SQLite CRUD Demo'),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            MyForm(saveToDB),
            new Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}
