import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate/utils/languages.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {

    // system language
    final locale = PlatformDispatcher.instance.locale;
    // final currentLanguage = useState(locale.languageCode);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode_outlined, color: Colors.black54),
            onPressed: () {
              debugPrint('mode switch');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_outlined, color: Colors.black54,),
            onPressed: null,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white38,
        ),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              // currentAccountPicture: ,
              accountName: Text('harves'),
              accountEmail: Text('harvesyang@gmail.com'),
            ),
            // Container(
            //   height: 100,
            // ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('通知设定', style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87
                ),),
                dense: true,
                trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                onTap: () => debugPrint('language'),
                // contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.language),
                title: const Text('语言', style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87
                ),),
                subtitle: const Text('默认显示跟随系统', style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey
                ),),
                dense: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(languages[locale.languageCode] ?? ''),
                    const SizedBox(width: 5,),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26)
                  ],
                ),
                onTap: () => _showLanguageSelection(context),
                // contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text('关于rate', style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87
                ),),
                dense: true,
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                onTap: () => _showAboutRate(context),
                // contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            )
          ],
        ),
      ),
    );
  } // build() end

  void _showLanguageSelection(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: CupertinoActionSheet(
            title: const Text('Please choose a language'),
            message: const Text('the language you use in this application'),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(
                fontSize: 14
              ),),
            ),
            actions: languages.entries.map((entry) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  debugPrint(entry.key);
                  Navigator.pop(context);
                },
                child: Text(entry.value, style: TextStyle(
                    fontSize: 14
                )),
              );
            }).toList(),
          ),
        );
      }
    );
  } // _showLanguageSelection() end


  void _showAboutRate(BuildContext context) {
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    showDialog(
        context: context,
        builder: (_) => AboutDialog(
          applicationIcon: FlutterLogo(),
          applicationVersion: 'v0.0.1',
          applicationName: 'Exchange Rate',
          applicationLegalese: 'Copyright© 2025-2030 Harves',
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                'Exchange Rate Service',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      color: Colors.blue,
                      offset: Offset(.5, .5),
                      blurRadius: 3
                    )
                  ]
                ),
              ),
            )
          ],
        )
    );
  } // _showAboutRate() end
}
