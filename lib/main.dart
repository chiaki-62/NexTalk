import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//ステートレスはビルドされるとreturn文以下が実行されるだけ、そのあとは外部の影響を受けない、トップページのような変わらない情報
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'NexTalk'),
    );
  }
}

//ステートフルはビルドされた後でもユーザーのインタラクションでデータが変わり際描画される部分がある。
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  //下のMyhomepagestateクラスを継承している。
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      //この中に状態の更新処理を書く
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //ページはScaffoldで囲む
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
            currentAccountPicture: Icon(Icons.account_circle, size: 64), //タップして画像設定　写真ライブラリから選択？
            accountEmail: Text('dev.test@gmail.com'),
            accountName: Text('Dev test'),
            ),
            ListTile(
              leading: Icon(Icons.phone_in_talk),
              title: Text('通話'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('チャット'),
            ),
            ListTile(
              leading: Icon(Icons.groups),
              title: Text('フレンド'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('設定'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'クリックカウント',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
