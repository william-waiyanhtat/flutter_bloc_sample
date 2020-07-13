import 'package:flutter/material.dart';
import 'package:flutter_demos/components/color_cell.dart';
import 'package:flutter_demos/components/link_btn.dart';
import 'package:flutter_demos/screens/login_screen.dart';
import 'package:flutter_demos/utils/app_settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //
  static List<Color> colors = [
    Colors.black87,
    Colors.blue,
    Colors.purple,
    Colors.indigo,
    Colors.green,
    Colors.teal,
    Colors.red,
    Colors.amber,
    Colors.orange,
    Colors.brown,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: context.watch<AppSettings>().appColor,
        elevation: 0,
        title: Text(
          'Settings',
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Wrap(
              children: List<Widget>.generate(
                colors.length,
                (index) => GestureDetector(
                  onTap: () async {
                    context.read<AppSettings>().updateColorTheme(index);
                  },
                  child: ColorCell(
                    color: colors[index],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            LinkBtn(
              btnTitle: 'Logout',
              onPress: () async {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
