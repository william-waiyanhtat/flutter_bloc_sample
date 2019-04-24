import 'package:flutter/material.dart';

class TabbedAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: directionsChoice.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tabbed AppBar'),
            bottom: TabBar(
              isScrollable: true,
              tabs: directionsChoice.map<Widget>((DirectionChoice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: directionsChoice.map<Widget>((DirectionChoice choice) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: DirectionChoicePage(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class DirectionChoice {
  final String title;
  final IconData icon;
  const DirectionChoice({this.title, this.icon});
}

const List<DirectionChoice> directionsChoice = <DirectionChoice>[
  DirectionChoice(title: 'CAR', icon: Icons.directions_car),
  DirectionChoice(title: 'BICYCLE', icon: Icons.directions_bike),
  DirectionChoice(title: 'BUS', icon: Icons.directions_bus),
  DirectionChoice(title: 'TRAIN', icon: Icons.directions_railway),
  DirectionChoice(title: 'WALK', icon: Icons.directions_walk),
];

class DirectionChoicePage extends StatelessWidget {
  const DirectionChoicePage({Key key, this.choice}) : super(key: key);

  final DirectionChoice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
