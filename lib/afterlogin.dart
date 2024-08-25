import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/post.dart';

class AfterLoginPage extends StatelessWidget {
  const AfterLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("After login"),
        actions: <Widget>[
          IconButton(
            // この下はログイン画面に戻る動きを書いてある。
            icon: Icon(Icons.close),
            onPressed: () async {
              // ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return SignInPage();
                }),
              );
            },
          ),
        ],
      ),
      // この下は投稿画面（postpage）に移動するボタンと動きを書いてる。
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          // この下のuserにFirebaseにあるユーザー情報を入れた。ここが元のと変わったところの一つ。
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return PostPage(user);
              }),
            );
          }
        },
      ),
    );
  }
}
