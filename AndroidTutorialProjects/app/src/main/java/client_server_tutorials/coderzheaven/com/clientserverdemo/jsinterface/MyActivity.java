package client_server_tutorials.coderzheaven.com.clientserverdemo.jsinterface;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.Toast;

public class MyActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WebView webView = new WebView(this);
        WebSettings settings = webView.getSettings();
        settings.setJavaScriptEnabled(true);
        webView.addJavascriptInterface(new MyJavascriptInterface(this), "MyJSClient");
        webView.loadUrl("file:///android_asset/test.html");
        setContentView(webView);
    }

    public class MyJavascriptInterface {

        Context context;

        public MyJavascriptInterface(Context context) {
            this.context = context;
        }

        @android.webkit.JavascriptInterface
        public void getStringFromJS(String txtVal) {
            Toast.makeText(context, "Value From JS : " + txtVal, Toast.LENGTH_LONG).show();
        }

    }
}
