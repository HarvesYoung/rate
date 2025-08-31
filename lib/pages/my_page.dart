import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rate/l10n/generated/app_localizations.dart';
import 'package:rate/pages/feedback_page.dart';
import 'package:rate/providers/locale_provider.dart';
import 'package:rate/providers/providers.dart';
import 'package:rate/utils/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rate/configs/configs.dart';

class MyPage extends HookConsumerWidget {
  MyPage({super.key});

  late final SharedPreferences prefs;
  late final isShowBadge = useState<bool>(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect(() {
      Future(() async {
        prefs = await SharedPreferences.getInstance();
        isShowBadge.value = prefs.getBool(AppConfig.savedNotificationKey) ?? false;
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode_outlined, color: Colors.black54),
            onPressed: () {
              Fluttertoast.showToast(
                msg: 'Under Developing',
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.grey
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none_outlined, color: Colors.black54,),
                onPressed: () => _handleNotificationClick(context)
              ),
              // control whether to show badge
              if(isShowBadge.value)Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(
                      color: Colors.white,
                      width: 2
                    )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white38,
        ),
        child: ListView(
          children: [
            // UserAccountsDrawerHeader(
            //   // currentAccountPicture: ,
            //   accountName: Text('harves'),
            //   accountEmail: Text('harvesyang@gmail.com'),
            // ),

            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(
                  AppLocalizations.of(context)!.notificationTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                dense: true,
                trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Theme.of(context).iconTheme.color),
                onTap: () => Navigator.of(context).pushNamed('notification')
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  AppLocalizations.of(context)!.languageDescription,
                  style: Theme.of(context).textTheme.bodySmall),
                dense: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      languages[ref.watch(localeProvider).languageCode] ?? '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Theme.of(context).iconTheme.color)
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
                title: Text(
                  AppLocalizations.of(context)!.feedback,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
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
                title: Text(
                  AppLocalizations.of(context)!.storage,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
                dense: true,
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
                onTap: () => Navigator.of(context).pushNamed('storage'),
                // contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),

            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  AppLocalizations.of(context)!.about,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
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
    showCupertinoModalPopup(
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


  void _handleNotificationClick(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // Make notification badge not display
    // prefs.setBool(AppConfig.savedNotificationKey, false);

    // jump to notification list page
    if(context.mounted) {
      Navigator.of(context).pushNamed('notificationList');
    }
  } // _handleNotificationClick() end
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