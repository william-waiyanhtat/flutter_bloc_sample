import 'package:flutter/material.dart';
import 'inherited_widgets/demo/first_screen.dart';
import 'inherited_widgets/demo/state_container.dart';

void main() {
  runApp(new StateContainer(child: new TodoApp()));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      home: new HomeScreen(),
    );
  }
}