import 'package:flutter/material.dart';
import 'user.dart';

class StateContainer extends StatefulWidget{
  final Widget child;
  final User user;

  StateContainer({
    @required this.child,
    this.user
  });

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => new StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  User user;

  void updateUserInfo({name}) {
    if (user == null) {
      user = new User(name);
      setState(() {
        user = user;
      });
    } else {
      setState(() {
        user.name = name ?? user.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
