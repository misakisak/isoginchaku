import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/language_page.dart';
// import 'package:flutter_application_1/pages/usage_page.dart';
import 'package:flutter_application_1/pages/FAQs.dart';
import 'package:flutter_application_1/afterlogin.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "設定",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        drawer: Drawer(
          backgroundColor: Colors.teal[400],
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                )
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'ホーム',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AfterLoginPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  '設定',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.white,
                ),
                title: Text(
                  'よくある質問',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FaqPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("言語設定"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguagePage(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("データを削除"),
            ),
            Divider(),
            ListTile(
              title: Text("使い方"),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => UsagePage(),
          //         ),
          //       );
          //     },
            ),
            Divider(),
            ListTile(
              title: Text("機種変更の際"),
            ),
            Divider(),
            ListTile(
              title: Text("利用規約"),
            ),
            Divider(),
            ListTile(
              title: Text("お問い合わせ"),
            ),
            Divider(),
            ListTile(
              title: Text("クレジット"),
            ),
            Divider(),
            ListTile(
              title: Text("バージョン"),
            ),
          ],
        )
    );
  }
}