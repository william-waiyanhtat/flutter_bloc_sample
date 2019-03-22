import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebviewDemo extends StatefulWidget {
  final String title;

  WebviewDemo({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebviewDemoState();
  }
}

JavascriptChannel snackbarJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
    name: 'SnackbarJSChannel',
    onMessageReceived: (JavascriptMessage message) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message.message),
      ));
    },
  );
}

class _WebviewDemoState extends State<WebviewDemo> {
  //
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Webview Demo'),
        actions: <Widget>[NavigationControls(_controller.future)],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: 'http://flutter.dev',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>[
              snackbarJavascriptChannel(context),
            ].toSet(),
          );
        },
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);
  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No Back history Item"),
                          ),
                        );
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No Forward history Item"),
                          ),
                        );
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      controller.reload();
                    },
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      showUserAgent(controller, context);
                    },
            )
          ],
        );
      },
    );
  }

  showUserAgent(WebViewController controller, BuildContext context) {
    controller.evaluateJavascript(
        'SnackbarJSChannel.postMessage("User Agent: " + navigator.userAgent);');
  }
}
