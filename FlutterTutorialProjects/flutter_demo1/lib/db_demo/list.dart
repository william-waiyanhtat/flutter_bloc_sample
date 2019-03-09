import 'package:flutter/material.dart';
import 'dart:async';
import 'employee.dart';

class MyList extends StatelessWidget {
  final Future<List<Employee>> employees;

  MyList(this.employees);

  SingleChildScrollView dataBody(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("NAME"),
          ),
          DataColumn(
            label: Text("AGE"),
          ),
          DataColumn(
            label: Text("MOBILE"),
          ),
        ],
        rows: employees
            .map(
              (user) => DataRow(
                    cells: [
                      DataCell(
                        Text(user.name),
                      ),
                      DataCell(
                        Text(user.age),
                      ),
                      DataCell(
                        Text(user.mobileNo),
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
    return new Expanded(
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
}
