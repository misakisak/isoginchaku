import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/settings.dart';
import 'package:flutter_application_1/afterlogin.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "よくある質問",
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
            title: Text("質問１"),
            subtitle: Text(
              "回答１....................................................................................................."
            ),
          ),
          Divider(),
          ListTile(
            title: Text("質問２"),
            subtitle: Text(
              "回答2....................................................................................................."
            ),
          ),
          Divider(),
          ListTile(
            title: Text("質問３"),
            subtitle: Text(
              "回答３....................................................................................................."
            ),
          ),
          Divider(),
          ListTile(
            title: Text("質問４"),
            subtitle: Text(
              "回答４....................................................................................................."
            ),
          ),
          Divider(),
          ListTile(
            title: Text("質問５"),
            subtitle: Text(
              "回答５....................................................................................................."
            ),
          ),
          ListTile(title: Text("")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // 任意の角丸さを指定
              ),
            ),
            onPressed: () {},
            child: Text(
              '質問または報告をする',
              style: TextStyle(color: Colors.teal[900]),
            ),
          )
        ],
      )
    );
  }
}