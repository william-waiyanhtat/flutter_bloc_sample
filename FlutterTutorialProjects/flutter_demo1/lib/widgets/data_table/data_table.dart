import 'package:flutter/material.dart';
import 'package:flutter_demo1/widgets/data_table/user.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Data Table Demo App";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<User> users;
  bool sort;
  bool selected;

  @override
  void initState() {
    sort = false;
    selected = false;
    users = User.getUsers();
    super.initState();
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (0 == columnIndex) {
      if (ascending) {
        users.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        users.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("First Name"),
              numeric: false,
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColumn(columnIndex, ascending);
              },
              tooltip: "This is the first name"),
          DataColumn(
              label: Text("Last Name"),
              numeric: false,
              onSort: (i, b) {},
              tooltip: "This is the last name"),
          DataColumn(
              label: Text("Place"),
              numeric: false,
              onSort: (i, b) {},
              tooltip: "This is the place"),
        ],
        rows: users
            .map(
              (user) => DataRow(
                    selected: selected,
                    onSelectChanged: (b) {
                      if (b) {
                        print('row-selected: ${user.firstName}');
                        setState(() {
                          selected = user.firstName == "a";
                        });
                      }
                    },
                    cells: [
                      DataCell(
                        Text(user.firstName),
                        onTap: () {
                          print("Tapped " + user.firstName);
                        },
                      ),
                      DataCell(
                        Text(user.lastName),
                      ),
                      DataCell(
                        Text(user.place),
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: dataBody(),
        ));
  }
}
