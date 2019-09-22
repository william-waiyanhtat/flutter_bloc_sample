import 'package:flutter/material.dart';
import 'package:flutter_demo1/widgets/MySQL_DataTable/Employees.dart';
import 'Services.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Data Table Flutter Demo";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employees;
  List<Employee> _selectedEmployees;
  bool sort;
  bool selected;
  GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController controller = TextEditingController();
  String _firstName;
  String _lastName;

  @override
  void initState() {
    sort = false;
    selected = false;
    _firstName = '';
    _lastName = '';
    _selectedEmployees = [];
    _employees = [];
    scaffoldKey = GlobalKey();
    _getEmployees();
    super.initState();
  }

  _createTable() {
    Services.createTable().then((result) {
      showSnackBar(context, result);
    });
  }

  _addEmployee() {
    if (_firstName.trim().isEmpty || _lastName.trim().isEmpty) {
      return;
    }
    Services.addEmployee(_firstName, _lastName).then((result) {
      if (result == 'success') {
        _getEmployees();
      }
      showSnackBar(context, result);
    });
  }

  _getEmployees() {
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      print("Length: ${employees.length}");
    });
  }

  _deleteEmployee() {
    if (_selectedEmployees.isNotEmpty) {
      List<Employee> temp = [];
      temp.addAll(_selectedEmployees);
      for (Employee employee in temp) {
        Services.deleteEmployee(employee.id).then((result) {
          if (result == 'success') {
            setState(() {
              _employees.remove(employee);
              _selectedEmployees.remove(employee);
            });
          }
        });
      }
    }
  }

  _onSelectedRow(bool selected, Employee employee) async {
    setState(() {
      if (selected) {
        _selectedEmployees.add(employee);
      } else {
        _selectedEmployees.remove(employee);
      }
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("ID"),
                numeric: false,
                tooltip: "This is the employee id"),
            DataColumn(
                label: Text(
                  "FIRST NAME",
                ),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("LAST NAME"),
                numeric: false,
                tooltip: "This is the last name"),
          ],
          rows: _employees
              .map(
                (employee) => DataRow(
                  selected: _selectedEmployees.contains(employee),
                  onSelectChanged: (b) {
                    _onSelectedRow(b, employee);
                  },
                  cells: [
                    DataCell(
                      Text(employee.id),
                      onTap: () {
                        print("Tapped " + employee.firstName);
                      },
                    ),
                    DataCell(
                      Text(
                        employee.firstName.toUpperCase(),
                      ),
                    ),
                    DataCell(
                      Text(
                        employee.lastName.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  showSnackBar(context, message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("SELECTED [${_selectedEmployees.length}]"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _selectedEmployees.isEmpty
                ? null
                : () {
                    _deleteEmployee();
                  },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: ((text) {
                  _firstName = text;
                }),
                decoration: InputDecoration.collapsed(
                  hintText: "Enter First Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: ((text) {
                  _lastName = text;
                }),
                decoration: InputDecoration.collapsed(
                  hintText: "Enter Last Name",
                ),
              ),
            ),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
