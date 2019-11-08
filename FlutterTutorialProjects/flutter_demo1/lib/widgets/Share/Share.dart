import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';

class Share {
  //
  static const MethodChannel channel =
      MethodChannel('plugins.flutter.io/share');

  // Wraps the platform's native share dialog. Can share a text and/or a URL.
  // It uses the `ACTION_SEND` Intent on Android and `UIActivityViewController`
  // on iOS.
  static Future<void> share(
    String text, {
    String subject,
    Rect sharePositionOrigin,
  }) {
    final Map<String, dynamic> params = <String, dynamic>{
      'text': text,
      'subject': subject,
    };

    if (null != sharePositionOrigin) {
      params['originX'] = sharePositionOrigin.left;
      params['originY'] = sharePositionOrigin.top;
      params['originWidth'] = sharePositionOrigin.width;
      params['originHeight'] = sharePositionOrigin.height;
    }

    return channel.invokeMethod<void>('share', params);
  }
}
