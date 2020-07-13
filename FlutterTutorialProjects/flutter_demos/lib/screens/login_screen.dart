import 'package:flutter/material.dart';
import 'package:flutter_demos/components/appbar.dart';
import 'package:flutter_demos/components/btn.dart';
import 'package:flutter_demos/components/link_btn.dart';
import 'package:flutter_demos/components/tf.dart';
import 'package:flutter_demos/screens/home_screen.dart';
import 'package:flutter_demos/utils/app_settings.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: context.watch<AppSettings>().appColor,
      //   title: Text('Widgets'),
      // ),
      appBar: IAppBar(
        height: 80,
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login'),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            TF(
              prefixIcon: null,
              borderColor: Colors.green,
            ),
            TF(),
            Row(
              children: [
                Expanded(
                  child: Btn(
                    btnTitle: 'Login',
                    color: context.watch<AppSettings>().appColor,
                    onPress: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            LinkBtn(
              btnTitle: 'Forgot Password?',
            )
          ],
        ),
      ),
    );
  }
}
