import 'package:flutter_application_1/afterlogin.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/notifiers.dart';
import 'package:flutter_application_1/pages/first_page.dart';



// firestoreをインポートする

// void main() {
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider<SingleNotifier>(
//         create: (_) => SingleNotifier(),
//       ),
//       //上を入れたときにproviderはpub.yamlに入れたので、下でmultipleの時を追加で宣言する。
//       ChangeNotifierProvider<MultipleNotifier>(
//         create: (_) => MultipleNotifier([]),
//       )
//     ],
//     child: MyApp(),
//   ));
// }

Future<void> main() async {
  // main 関数でも async が使えます
  WidgetsFlutterBinding.ensureInitialized(); // runApp 前に何かを実行したいときはこれが必要です。
  await Firebase.initializeApp(
    // これが Firebase の初期化処理です。
    options: DefaultFirebaseOptions.android,
  );
  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SingleNotifier>(
        create: (_) => SingleNotifier(),
      ),
      //上を入れたときにproviderはpub.yamlに入れたので、下でmultipleの時を追加で宣言する。
      ChangeNotifierProvider<MultipleNotifier>(
        create: (_) => MultipleNotifier([]),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<void> signInWithGoogle() async {
    // GoogleSignIn をして得られた情報を Firebase と関連づけることをやっています。
    final googleUser =
        await GoogleSignIn(scopes: ['profile', 'email']).signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "ここが始まりだ",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
         backgroundColor: Colors.teal
      ),
      body: Center(
          child: ElevatedButton(
            //この中はボタンについての設定
            // child: const Text('GoogleSignIn'),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: ElevatedButton(
                    child: Text(
                      "Googleでサインインして冒険を始めよう",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.teal[900]),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstPage()),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
          onPressed: () async {
            await signInWithGoogle();
            // ログインが成功すると FirebaseAuth.instance.currentUser にログイン中のユーザーの情報が入ります
            // このFirebaseAuth.instance.currentUserから、afterloginのページで情報を取ってくる
            // ６９行目のコメントアウトしてるところはafterloginにあるのと同じ処理で、二か所で同じことやる必要ないかなと思って消した。（あってもなくても特に変化はなかった。）
            //final User? user = FirebaseAuth.instance.currentUser;
            print(FirebaseAuth.instance.currentUser?.displayName);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AfterLoginPage()),
            );
          },
        ),
      ),
    );
  }
}