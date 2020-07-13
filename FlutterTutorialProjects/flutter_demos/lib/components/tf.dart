import 'package:flutter/material.dart';

class TF extends StatelessWidget {
  TF({
    this.controller,
    this.hintText,
    this.helpText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword,
    this.enabled,
    this.readOnly,
    this.borderColor,
  });

  final TextEditingController controller;
  final String hintText;
  final String helpText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        readOnly: null == readOnly ? false : true,
        obscureText: null == isPassword ? false : isPassword,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          border: new OutlineInputBorder(
            borderSide: new BorderSide(
              color: null == borderColor ? Colors.teal : borderColor,
            ),
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.all(20.0),
          prefixIcon: null == suffixIcon ? null : Icon(prefixIcon),
          suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
          enabled: null == enabled ? true : enabled,
        ),
      ),
    );
  }
}
