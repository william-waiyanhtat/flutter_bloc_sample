import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demos/utils/app_settings.dart';

class IAppBar extends PreferredSize {
  final Widget child;
  final double height;

  IAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: context.watch<AppSettings>().appColor,
      alignment: Alignment.center,
      child: child,
    );
  }
}
