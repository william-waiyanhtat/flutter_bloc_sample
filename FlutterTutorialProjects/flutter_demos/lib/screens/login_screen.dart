import 'package:flutter/material.dart';
import 'package:flutter_demos/components/btn.dart';
import 'package:flutter_demos/components/link_btn.dart';
import 'package:flutter_demos/components/tf.dart';
import 'package:flutter_demos/utils/Utils.dart';
import 'package:flutter_demos/utils/appsettings.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: Container(
        child: Column(
          children: [
            AppTextFormField(
              controller: _emailController,
              helpText: 'Email',
              hintText: 'Email',
              prefixIcon: Icons.email,
            ),
            AppTextFormField(
              controller: _passwordController,
              helpText: 'Password',
              hintText: 'Password',
              isPassword: true,
              prefixIcon: Icons.lock_open,
            ),
            Row(
              children: [
                Expanded(
                  child: Btn(
                    onPress: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    },
                    text: 'LOGIN',
                    color: context.watch<AppSettings>().appColor,
                  ),
                )
              ],
            ),
            LinkBtn(
              text: 'Forgot Password?',
              color: Colors.green,
              onPress: () {
                //
              },
            )
          ],
        ),
      ),
    );
  }
}
