import 'package:flutter/material.dart';
import 'package:flutter_demo1/inherited_widgets/demo1/state_container.dart';

class FormScreen extends StatefulWidget {
  FormScreen();

  @override
  State<StatefulWidget> createState() {
    return _FormScreenState();
  }
}

class _FormScreenState extends State<FormScreen> {
  String name;
  final formKey = new GlobalKey<FormState>();

  validateFormAndSave() {
    final container = StateContainer.of(context);

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('Name $name');

      container.updateUserInfo(name: name);

      //
      Navigator.pop(context);
    } else {
      print("Validation Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Form Demo'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (val) => val.length == 0 ? "Enter Name" : null,
                    onSaved: (val) => name = val,
                  ),
                  RaisedButton(
                    child: Text("Save"),
                    onPressed: validateFormAndSave,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
