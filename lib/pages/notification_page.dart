
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rate/l10n/generated/app_localizations.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  bool isAllowedNotification = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.notificationTitle),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white38,
        ),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(AppLocalizations.of(context)!.receiveNotification),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: isAllowedNotification,
                      onChanged:  (_) => _openSettings(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  } // build() end


  Future<void> _checkPermission() async {
    final messaging = FirebaseMessaging.instance;

    // request for permission of notification
    final settings = await messaging.requestPermission();
    bool isAllowed =  settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
    setState(() => isAllowedNotification = isAllowed);
  } // _checkPermission() end


  Future<void> _openSettings() async {
    await openAppSettings();
  } // _openSettings() end
}
