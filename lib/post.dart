import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage(this.user, {Key? key}) : super(key: key); //constを削除しKeyをオプションに
  final User user;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String messageText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post Page"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 投稿メッセージ入力
              TextFormField(
                decoration: InputDecoration(labelText: '投稿メッセージ'),
                // 複数行のテキスト入力
                keyboardType: TextInputType.multiline,
                // 最大3行
                maxLines: 3,
                onChanged: (String value) {
                  setState(() {
                    messageText = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('投稿'),
                  onPressed: () async {
                    final date =
                        DateTime.now().toLocal().toIso8601String(); // 現在の日時
                    final email = widget.user.email; // AddPostPage のデータを参照
                    // 投稿メッセージ用ドキュメント作成
                    await FirebaseFirestore.instance
                        .collection('posts')
                        // コレクションID指定
                        .doc('thisisatestid00')
                        // ドキュメントID自動生成←これを自動生成じゃなくする、下にcollectionを繋げればできるはず
                        // 例えばトイレ１を選択してポストのボタンを押すと、投稿画面にいって、投稿すると、
                        // まず、トイレのコレクションにいって、さらにその緯度経度を連結したIDのドキュメントにいく
                        // さらにそのドキュメントの中に、今投稿ボタンを押しているから、ratingに移動する
                        // そのratingの中にランダムなIDを持つ投稿が反映される
                        .collection('rating')
                        .doc()
                        .set({
                      'text': messageText,
                      'email': email,
                      'date': date
                    });
                    // 1つ前の画面に戻る
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
