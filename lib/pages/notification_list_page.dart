import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/widgets/widgets.dart';

class NotificationListPage extends HookWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationList = useState<Future<List<String>>?>(null);

    useEffect((){
      // Request for data only if notification list is empty
      if(notificationList.value == null) {
        notificationList.value = _fetchNotificationList();
      }
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('notifications'),
      ),
      body: FutureBuilder(
        future: notificationList.value,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('has error');
          }
          if(snapshot.connectionState == ConnectionState.done) {
            return NotificationListItemWidget();
          }
          return const NotificationLoadingWidget();
        },
      ),
    );
  } // build() end


  /// load the notification list data
  Future<List<String>> _fetchNotificationList() async {
    return await Future.delayed(const Duration(seconds: 1), () {
      debugPrint('delayed');
      return ['title A', 'title B'];
    });
  } // _fetchNotificationData() end
}