import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/ThemeDemo/ThemeDemo.dart';
import 'widgets/ThemeDemo/AppTheme.dart';
import 'widgets/ThemeDemo/AppNotifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppNotifier>(
      builder: (context) => AppNotifier(),
      child: HomeApp(),
    ),
  );
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: 'Flutter Tutorials',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme, // ThemeData(primarySwatch: Colors.blue),
          darkTheme:
              AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
          home: ThemeDemo(),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}

/*
// Wrap main widget inside the StreamProvider
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>(
      builder: (context) => ConnectivityService().connectionStatusController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tutorials',
        home: new ConnectivityDemo(),
      ),
    );
  }
}
*/

/*
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: FirstScreen(),
      routes: {
        FirstScreen.routeId: (context) => FirstScreen(),
        SecondScreen.routeId: (context) => SecondScreen(),
      },
      initialRoute: FirstScreen.routeId,
    );
  }
}
*/
