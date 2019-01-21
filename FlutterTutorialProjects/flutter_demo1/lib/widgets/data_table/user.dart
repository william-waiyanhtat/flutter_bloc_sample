import 'package:flutter/material.dart';

class User {
  String firstName;
  String lastName;
  String place;

  List<User> users;

  User({this.firstName, this.lastName, this.place});

  static List<User> getUsers() {
    return <User>[
      User(firstName: "a", lastName: "a1", place: "p1"),
      User(firstName: "b", lastName: "a2", place: "p2"),
      User(firstName: "c", lastName: "a3", place: "p3"),
      User(firstName: "d", lastName: "a3", place: "p3"),
      User(firstName: "e", lastName: "a3", place: "p3"),
    ];
  }

  // void _sort<T>(Comparable<T> getField(User d), bool ascending) {
  //   users.sort((User a, User b) {
  //     if (!ascending) {
  //       final User c = a;
  //       a = b;
  //       b = c;
  //     }
  //     final Comparable<T> aValue = getField(a);
  //     final Comparable<T> bValue = getField(b);
  //     return Comparable.compare(aValue, bValue);
  //   });
  //   notifyListeners();
  // }

  // int _selectedCount = 0;

  // @override
  // DataRow getRow(int index) {
  //   assert(index >= 0);
  //   if (index >= users.length) return null;
  //   final User dessert = users[index];
  //   return new DataRow.byIndex(
  //       index: index,
  //       selected: dessert.selected,
  //       onSelectChanged: (bool value) {
  //         if (dessert.selected != value) {
  //           _selectedCount += value ? 1 : -1;
  //           assert(_selectedCount >= 0);
  //           dessert.selected = value;
  //           notifyListeners();
  //         }
  //       },
  //       cells: <DataCell>[
  //         new DataCell(new Text('${dessert.name}')),
  //         new DataCell(new Text('${dessert.calories}')),
  //         new DataCell(new Text('${dessert.fat.toStringAsFixed(1)}')),
  //         new DataCell(new Text('${dessert.carbs}')),
  //         new DataCell(new Text('${dessert.protein.toStringAsFixed(1)}')),
  //         new DataCell(new Text('${dessert.sodium}')),
  //         new DataCell(new Text('${dessert.calcium}%')),
  //         new DataCell(new Text('${dessert.iron}%')),
  //       ]);
  // }

  // @override
  // int get rowCount => users.length;

  // @override
  // bool get isRowCountApproximate => false;

  // @override
  // int get selectedRowCount => _selectedCount;

  // void _selectAll(bool checked) {
  //   for (User dessert in _desserts) dessert.selected = checked;
  //   _selectedCount = checked ? _desserts.length : 0;
  //   notifyListeners();
  // }
}
