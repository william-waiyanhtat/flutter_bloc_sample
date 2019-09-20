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

  @override
  void initState() {
    sort = false;
    selected = false;
    _selectedEmployees = [];
    _employees = [];
    _getEmployees();
    super.initState();
  }

  _addEmployee() {}
  _getEmployees() {
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      print("Length: ${employees.length}");
    });
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

  _onSortColumn(int columnIndex, bool ascending) async {
    if (0 == columnIndex) {
      if (ascending) {
        _employees.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        _employees.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }
  }

  _deleteSelected() async {
    setState(() {
      if (_selectedEmployees.isNotEmpty) {
        List<Employee> temp = [];
        temp.addAll(_selectedEmployees);
        for (Employee employee in temp) {
          _employees.remove(employee);
          _selectedEmployees.remove(employee);
        }
      }
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("ID"),
              numeric: false,
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                _onSortColumn(columnIndex, ascending);
              },
              tooltip: "This is the employee id"),
          DataColumn(
              label: Text(
                "FIRST NAME",
              ),
              numeric: false,
              onSort: (i, b) {},
              tooltip: "This is the last name"),
          DataColumn(
              label: Text("LAST NAME"),
              numeric: false,
              onSort: (i, b) {},
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
                    Text(employee.firstName.toUpperCase()),
                  ),
                  DataCell(
                    Text(employee.lastName.toUpperCase()),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SELECTED [${_selectedEmployees.length}]"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addEmployee();
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
                    _deleteSelected();
                  },
          ),
        ],
      ),
      body: _dataBody(),
    );
  }
}
