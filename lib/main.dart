import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'emptyappbar.dart';
void main() => runApp(MyApp());
// ignore: prefer_collection_literals

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff454552),
      ),
      home: MyHomePage(),
      routes: {
        '/home':(BuildContext context) => MyHomePage(title: 'Flutter Demo Home Page')
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.url}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String url;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  String token;
  String url='http://successking.dreamforone.co.kr';

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    flutterWebviewPlugin.close();
    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
          // ignore: unrelated_type_equality_checks
          if(state.url==WebViewState.finishLoad) {


          }
        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {

      if (mounted) {
        RegExp regExp = new RegExp("#access_token=(.*)");
        this.token = regExp.firstMatch(url)?.group(1);
        print("token $token");
      }
    });



  }


  @override
  Widget build(BuildContext context) {


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WebviewScaffold(
      url: url,
      withJavascript: true,
      withZoom: false,
      hidden: true,
      appBar: EmptyAppBar(),
      supportMultipleWindows: true,
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: 'readwrite',
            onMessageReceived: (JavascriptMessage message) async{
              print('javascript::${message.message}');
              String param=message.message;
            }
        ),
      ]),
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('로딩중...'),
        ),
      ),
    );
  }

}
/*
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'images/splash.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}*/

