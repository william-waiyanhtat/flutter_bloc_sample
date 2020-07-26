import 'package:flutter/material.dart';
import 'package:flutter_demos/components/color_cell.dart';
import 'package:flutter_demos/components/link_btn.dart';
import 'package:flutter_demos/screens/login_screen.dart';
import 'package:flutter_demos/utils/Utils.dart';
import 'package:flutter_demos/utils/appsettings.dart';
import '../utils/constants.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  //
  static const ROUTE_ID = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<AppSettings>().appColor,
        title: Text('Settings'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Wrap(
              children: List<Widget>.generate(Constants.colors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    context.read<AppSettings>().updateColor(index);
                    Utils.saveThemeIndex(index);
                  },
                  child: ColorCell(
                    color: Constants.colors[index],
                  ),
                );
              }),
            ),
            LinkBtn(
              text: 'Logout',
              onPress: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.ROUTE_ID, (route) => false);
                Utils.saveLoggedIn(false);
                Utils.saveThemeIndex(0);
                context.read<AppSettings>().updateColor(0);
              },
            )
          ],
        ),
      ),
    );
  }
}
