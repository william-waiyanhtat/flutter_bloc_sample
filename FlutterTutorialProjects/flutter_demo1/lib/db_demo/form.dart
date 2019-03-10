import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final formKey = new GlobalKey<FormState>();

  final Function saveToDB;

  MyForm(this.saveToDB);

  @override
  State<StatefulWidget> createState() {
    return _MyFormState();
  }
}

class _MyFormState extends State<MyForm> {
  String firstName;
  String lastName;

  validate() {
    if (widget.formKey.currentState.validate()) {
      widget.formKey.currentState.save();
      widget.saveToDB(firstName, lastName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: widget.formKey,
      child: new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'First Name'),
                validator: (val) => val.length == 0 ? "Enter First Name" : null,
                onSaved: (val) => firstName = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'Last Name'),
                validator: (val) => val.length == 0 ? "Enter Last Name" : null,
                onSaved: (val) => this.lastName = val,
              ),
              new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: new RaisedButton(
                  onPressed: validate,
                  child: new Text('SAVE'),
                ),
              )
            ]),
      ),
    );
  }
}
