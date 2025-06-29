import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/l10n/generated/app_localizations.dart';
import 'package:rate/pages/feedback_page.dart';
import 'package:rate/providers/locale_provider.dart';
import 'package:rate/utils/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate/configs/configs.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                title: Text(
                  AppLocalizations.of(context)!.notificationTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87
                  ),
                ),
                dense: true,
                trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                onTap: () => Navigator.of(context).pushNamed('notification')
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language, style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87
                ),),
                subtitle: Text(
                  AppLocalizations.of(context)!.languageDescription,
                  style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey
                ),),
                dense: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(languages[ref.watch(localeProvider).languageCode] ?? ''),
                    const SizedBox(width: 5,),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26)
                  ],
                ),
                onTap: () => _showLanguageSelection(context, ref),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade100,
                    width: 1
                  )
                )
              ),
              child: ListTile(
                leading: const Icon(Icons.feedback),
                title: Text(AppLocalizations.of(context)!.feedback, style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87
                ),),
                dense: true,
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                onTap: () => Navigator.of(context).push(
                  NoSwipeCupertinoPageRoute(
                    builder: (_) => FeedbackPage()
                  )
                )
                // contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade100,
                    width: 1
                  )
                )
              ),
              child: ListTile(
                leading: const Icon(Icons.storage),
                title: Text(AppLocalizations.of(context)!.storage, style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87
                ),),
                dense: true,
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                onTap: () => Navigator.of(context).pushNamed('storage'),
                // contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Text(AppLocalizations.of(context)!.about, style: TextStyle(
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

  void _showLanguageSelection(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: CupertinoActionSheet(
            title: Text(AppLocalizations.of(context)!.languageTitle),
            message: Text(AppLocalizations.of(context)!.languageSubTitle),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel, style: TextStyle(
                fontSize: 14
              ),),
            ),
            actions: languages.entries.map((entry) {
              return CupertinoActionSheetAction(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(AppConfig.savedLocaleCodeKey, entry.key);

                  ref.read(localeProvider.notifier).state = Locale(entry.key);

                  if(!context.mounted) return;
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

class NoSwipeCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  NoSwipeCupertinoPageRoute({
    required super.builder
  });

  // not good
  // NoSwipeCupertinoPageRoute({
  //   required WidgetBuilder builder
  // }) : super(builder: builder);

  @override
  bool get popGestureEnabled => false;
}