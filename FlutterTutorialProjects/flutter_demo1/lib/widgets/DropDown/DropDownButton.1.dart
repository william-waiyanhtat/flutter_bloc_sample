import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  //
  List _companies = ["Apple", "Google", "Sony", "Samsung", "LG"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedCompany;

  @override
  void initState() {
    _dropDownMenuItems = buildDropDownMenuItems(_companies);
    _selectedCompany = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List companies) {
    List<DropdownMenuItem<String>> items = new List();
    for (String company in _companies) {
      items.add(new DropdownMenuItem(value: company, child: new Text(company)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedCompany = selectedFruit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("DropDown Button Example"),
        ),
        body: new Container(
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Select a company "),
                SizedBox(
                  height: 20,
                ),
                new DropdownButton(
                  value: _selectedCompany,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Selected: $_selectedCompany'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
