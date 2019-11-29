import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class FlushBarDemo extends StatefulWidget {
  //
  final String title = "FlushBar Demo";
  @override
  FlushBarDemoState createState() => FlushBarDemoState();
}

class FlushBarDemoState extends State<FlushBarDemo> {
  //
  Flushbar flush;
  String inputVal = '';
  TextEditingController controller;

  //
  Flushbar<List<String>> flush2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Form userInputForm;

  TextFormField getFormField() {
    return TextFormField(
      controller: controller,
      initialValue: null,
      style: TextStyle(color: Colors.white),
      maxLength: 100,
      maxLines: 1,
      maxLengthEnforced: true,
      decoration: InputDecoration(
          fillColor: Colors.white10,
          filled: true,
          icon: Icon(
            Icons.label,
            color: Colors.green[500],
          ),
          border: UnderlineInputBorder(),
          helperText: "Name",
          helperStyle: TextStyle(color: Colors.grey),
          labelText: "Type your name",
          labelStyle: TextStyle(color: Colors.grey)),
    );
  }

  withInputField(BuildContext context) {
    flush2 = Flushbar<List<String>>(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticInOut,
      userInputForm: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getFormField(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  child: Text('DONE'),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red),
                  ),
                  color: Colors.white,
                  textColor: Colors.red,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {
                    flush2.dismiss([controller.text, 'world']);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    )..show(context).then(
        (result) {
          if (result != null) {
            String userInput1 = result[0];
            String userInput2 = result[1];
            print(userInput1 + userInput2);
            setState(() {
              inputVal = userInput1 + ', ' + userInput2;
            });
          }
        },
      );
  }

  custom(BuildContext context) {
    flush = Flushbar(
      title: "Hello",
      message: "Sample Message",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticInOut,
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
            color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      backgroundGradient:
          LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: false,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      mainButton: FlatButton(
        onPressed: () {
          flush.dismiss();
        },
        child: Text(
          "DONE",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      titleText: Text(
        "Title",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.yellow,
          fontFamily: "Roboto-Medium",
        ),
      ),
      messageText: Text(
        "Sample Message",
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.green,
          fontFamily: "Roboto-Medium",
        ),
      ),
    )..show(context);
  }

  normal(BuildContext context) {
    Flushbar(
      title: "Hello there",
      message: "How are you?",
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      onStatusChanged: (FlushbarStatus status) {
        switch (status) {
          case FlushbarStatus.SHOWING:
            {
              break;
            }
          case FlushbarStatus.IS_APPEARING:
            {
              break;
            }
          case FlushbarStatus.IS_HIDING:
            {
              break;
            }
          case FlushbarStatus.DISMISSED:
            {
              break;
            }
        }
      },
    )..show(context);
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlushBar Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              child: Text("Normal"),
              onPressed: () {
                normal(context);
              },
            ),
            OutlineButton(
              child: Text("Custom With Icon"),
              onPressed: () {
                custom(context);
              },
            ),
            OutlineButton(
              child: Text("With Input"),
              onPressed: () {
                withInputField(context);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(inputVal),
          ],
        ),
      ),
    );
  }
}
