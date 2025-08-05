import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/providers/is_notification_available_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomNotificationSetting extends HookConsumerWidget {
  const CustomNotificationSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isNotificationAvailable = ref.watch(isNotificationAvailableProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('notification setting'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.notification_important_outlined),
              title: const Text('接收消息', style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87
              ),),
              subtitle: const Text('是否接收来自app的消息通知', style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey
              ),),
              dense: true,
              trailing: CupertinoSwitch(
                value: isNotificationAvailable,
                onChanged: (bool newValue) async {
                  _handleNotificationToggle(context, ref, newValue);
                }
              ),
            ),
          ),
        ],
      )
    );
  } // build() end

  // 处理
  Future<void> _handleNotificationToggle(BuildContext context, WidgetRef ref, bool newValue) async {
    // current notification status
    final currentStatus = await Permission.notification.status;
    
    if(!currentStatus.isGranted) {
      final result = await Permission.notification.request();
      if(result.isGranted) {
        _updateNotificationSetting(ref, newValue);
      } else if(result.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        if(context.mounted) _showSnackBar(context, '通知权限未授予');
      }
    } else {
      await _updateNotificationSetting(ref, newValue);
    }
  } // _handleNotificationToggle() end

  // 保存最新的结果，并更新UI
  Future<void> _updateNotificationSetting(WidgetRef ref, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConfig.kNotificationSwitchKey,  value);
    ref.read(isNotificationAvailableProvider.notifier).state = value;
  } // _updateNotificationSetting() end

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  } // _showSnackBar() end
}