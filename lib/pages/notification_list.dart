import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/widgets/notification_list_widget.dart';


class NotificationList extends HookWidget {
  const NotificationList({super.key});


  @override
  Widget build(BuildContext context) {
    final notificationList = useState<Future<List<String>>?>(null);

    useEffect((){
      notificationList.value = _fetchNotificationList();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('notification list'),
      ),
      body: FutureBuilder(
        future: notificationList.value,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('has error');
          }
          if(snapshot.connectionState == ConnectionState.done) {
            debugPrint(notificationList.toString());
            return NotificationListWidget();
          }
          return const Text('加载····');
        },
      ),
    );
  } // build() end


  /// load the notification list data
  Future<List<String>> _fetchNotificationList() async {
    return await Future.delayed(const Duration(seconds: 4), () {
      debugPrint('delayed');
      return ['title A', 'title B'];
    });
  } // _fetchNotificationData() end
}