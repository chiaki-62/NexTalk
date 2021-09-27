import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  //Firebaseの初期化 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: MyAuthPage(),
    );
  }
}

//ステートフルはビルドされた後でもユーザーのインタラクションでデータが変わり際描画される部分がある。
class MyAuthPage extends StatefulWidget {
  const MyAuthPage({Key? key,}) : super(key: key);
  //下のMyhomepagestateクラスを継承している。
  @override
  State<MyAuthPage> createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {

  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";
    
  @override
  Widget build(BuildContext context) {
    //ページはScaffoldで囲む
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                //テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged : (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード(6文字以上)"),
                //パスワードを見えなくする処理
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    //メール/パスワードでユーザー登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                      await auth.createUserWithEmailAndPassword(
                        email: newUserEmail,
                        password: newUserPassword,
                      );

                    //登録したユーザー情報
                    final User user = result.user!;
                    setState(() {
                      infoText = "登録OK:${user.email}";
                    });
                  } catch (e) {
                    //登録に失敗した場合
                    setState(() {
                      infoText = "登録NG:${e.toString()}";
                    });
                  }
                },
                child: Text("ユーザー登録"),
              ),
              const SizedBox(height: 8),
              Text(infoText)
            ],
          ),
        ),
      ),
    );
  }
}
