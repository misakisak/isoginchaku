import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/data.dart';
import 'package:flutter_application_1/pages/notifiers.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            '言語設定',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Center(
            child: ListView(
                children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: Text('言語設定'),
            onTap: () => _showSingleChoiceDialog(context),
          ),
        ]).toList())));
  }
}

_showSingleChoiceDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      var _singleNotifier = Provider.of<SingleNotifier>(context);
      return AlertDialog(
          title: Text("言語を選択する"),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: languages
                    .map((e) => RadioListTile(
                          title: Text(e),
                          value: e,
                          groupValue: _singleNotifier.currentLanguage,
                          selected: _singleNotifier.currentLanguage == e,
                          onChanged: (value) {
                            if (value != _singleNotifier.currentLanguage) {
                              _singleNotifier.updateLanguage(value!);
                              Navigator.of(context).pop();
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
          ));
    });
/*import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LanguagePage extends HookWidget {
  const LanguagePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageList = [
      'Japanese',
      'English',
      'Simple Japanese',
    ];

    final selectedIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Language Settings"),
        elevation: 0,
        backgroundColor: Colors.deepPurple[100],
      ),
      body: ListView.builder(
        itemCount: LanguageList.length,
        itemBuilder: (_, index) {
          final sampleItem = LanguageList[index];
          return RadioListTile(
              title: Text(sampleItem),
              value: index,
              groupValue: selectedIndex.value,
              onChanged: (int? value) {
                selectedIndex.value = index;
              });
        },
      ),
    );
  }
}*/
